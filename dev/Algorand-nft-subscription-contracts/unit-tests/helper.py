'''
Copyright (c) 2022 Algorand Name Service DAO LLC

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
'''

from algosdk import mnemonic, account, encoding
from algosdk.future import transaction
from algosdk.future.transaction import LogicSig, LogicSigTransaction, LogicSigAccount
from algosdk.v2client import algod, indexer
from algosdk import logic
import json
from pyteal import *

import sys
sys.path.append('../')

from contracts.nft_subscription import approval_program, clear_state_program
import base64
import datetime,time
import mysecrets

def SetupClient(network):

    if(network=="sandbox"):
        # Local sandbox node 
        algod_address = "http://localhost:4001"
        algod_token = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"

    elif(network=="purestake"):
        # Purestake conn
        algod_address = "https://testnet-api.algonode.cloud"
        
    else:
        raise ValueError

    algod_client=algod.AlgodClient('', algod_address, '')
    return algod_client

def SetupIndexer(network):
    if(network=="purestake"):
        algod_address = "https://testnet-idx.algonode.cloud"
        
        algod_indexer=indexer.IndexerClient("", algod_address, "")
    
    return algod_indexer

def GetFundingAccount(algod_client):

    passphrase = mysecrets.FUNDING_ACCOUNT_MNEMONIC

    private_key = mnemonic.to_private_key(passphrase)
    sender = account.address_from_private_key(private_key)

    account_info = algod_client.account_info(sender)

    return sender, passphrase

def GenerateAccount():
    new_private_key, new_address = account.generate_account()
    return new_address, mnemonic.from_private_key(new_private_key)

def FundNewAccount(algod_client, receiver, amount, funding_acct_mnemonic):

    sender_private_key=mnemonic.to_private_key(funding_acct_mnemonic)
    sender=account.address_from_private_key(sender_private_key)

    unsigned_txn = transaction.PaymentTxn(sender, algod_client.suggested_params(), receiver,amount, None)
    signed_txn = unsigned_txn.sign(sender_private_key)

    #submit transaction
    txid = algod_client.send_transaction(signed_txn)
    print("Successfully sent transaction with txID: {}".format(txid))

    # wait for confirmation 
    try:
        confirmed_txn = wait_for_confirmation(algod_client,txid)  
    except Exception as err:
        print(err)
        return

def DeployContract(algod_client, contract_owner_mnemonic):

    private_key=mnemonic.to_private_key(contract_owner_mnemonic)
    sender=account.address_from_private_key(private_key)

    # Setup Schema
    local_ints = 4 
    local_bytes = 12 
    global_ints = 6 
    global_bytes = 6 
    global_schema = transaction.StateSchema(global_ints, global_bytes)
    local_schema = transaction.StateSchema(local_ints, local_bytes)

    on_complete = transaction.OnComplete.NoOpOC.real

    compileTeal(approval_program(), Mode.Application,version=6)
    compileTeal(clear_state_program(), Mode.Application,version=6)

    contract_approval_program = compile_program(algod_client, import_teal_source_code_as_binary('nft_subscription_approval.teal'))
    contract_clear_state_program = compile_program(algod_client, import_teal_source_code_as_binary('nft_subscription_clear_state.teal'))
    
    price = 1000000
    duration = 10

    app_args = [
        b'NFT',
        b'Non Fungible Token',
        b'https://nft.com',
        price.to_bytes(8, 'big'),
        duration.to_bytes(8, 'big')
    ]

    txn = transaction.ApplicationCreateTxn(sender, algod_client.suggested_params(), on_complete, contract_approval_program, contract_clear_state_program, global_schema, local_schema, app_args, accounts=[sender])

    # sign transaction
    signed_txn = txn.sign(private_key)
    tx_id = signed_txn.transaction.get_txid()

    # send transaction
    algod_client.send_transactions([signed_txn])

    # await confirmation
    wait_for_confirmation(algod_client, tx_id)

    # display results
    transaction_response = algod_client.pending_transaction_info(tx_id)
    app_id = transaction_response['application-index']
    print("Deployed new contract with App-id: ",app_id)

    return app_id

def optin(algod_client, app_id, sender, private_key):
    optin_txn_unsign = transaction.ApplicationOptInTxn(sender, algod_client.suggested_params(), app_id)
    signed_txn = optin_txn_unsign.sign(private_key)
    txid = optin_txn_unsign.get_txid()
    algod_client.send_transaction(signed_txn)
    wait_for_confirmation(algod_client, txid)    

    print('Successfully opted in')
    
def fund_app(algod_client, app_id, sender, private_key):
    receiver = logic.get_application_address(app_id)
    optin_txn_unsign = transaction.PaymentTxn(sender, algod_client.suggested_params(), receiver, 1000000)
    signed_txn = optin_txn_unsign.sign(private_key)
    txid = optin_txn_unsign.get_txid()
    algod_client.send_transaction(signed_txn)
    wait_for_confirmation(algod_client, txid)    

    print('Successfully funded escrow account')

def subscribe(algod_client, app_id, sender, receiver, private_key):

    Grp_txns_unsign = []
    #reg_escrow_acct = logic.get_application_address(app_id)
    pmnt_txn_unsign = transaction.PaymentTxn(sender, algod_client.suggested_params(), receiver, 1000000, None)
    Grp_txns_unsign.append(pmnt_txn_unsign)

    # 4. Write name and owner's address in local storage
    duration = 1
    txn_args = [
        "subscribe".encode("utf-8"),
        duration.to_bytes(8, 'big')
    ]
    app_call_txn = transaction.ApplicationNoOpTxn(sender, algod_client.suggested_params(), app_id, txn_args)
    Grp_txns_unsign.append(app_call_txn)

    gid = transaction.calculate_group_id(Grp_txns_unsign)
    for i in range(0,2):
        Grp_txns_unsign[i].group = gid

    signed_txns = [Grp_txns_unsign[0].sign(private_key), Grp_txns_unsign[1].sign(private_key)]
    algod_client.send_transactions(signed_txns)
    wait_for_confirmation(algod_client, pmnt_txn_unsign.get_txid())


def accept_nft(algod_client, app_id, sender, private_key):

    
    txn_args = [
        "accept_nft".encode("utf-8")
    ]
    assets=[
        get_local_state(sender, app_id)
    ]
    app_call_txn = transaction.ApplicationNoOpTxn(sender, algod_client.suggested_params(), app_id, txn_args, foreign_assets=assets)
    
    algod_client.send_transaction(app_call_txn.sign(private_key))
    wait_for_confirmation(algod_client, app_call_txn.get_txid())

def destroy_nft(algod_client, app_id, sender, owner, private_key):

    
    txn_args = [
        "destroy_nft".encode("utf-8")
    ]
    assets=[
        get_local_state(owner, app_id)
    ]
    app_call_txn = transaction.ApplicationNoOpTxn(sender, algod_client.suggested_params(), app_id, txn_args, accounts=[owner], foreign_assets=assets)
    
    algod_client.send_transaction(app_call_txn.sign(private_key))
    wait_for_confirmation(algod_client, app_call_txn.get_txid())

def get_local_state(address, app_id):
    # TODO: Make sure there are no edge cases
    algod_indexer = SetupIndexer("purestake")
    #reg_escrow_acct = logic.get_application_address(reg_app_id)
    for apps_local_data in algod_indexer.account_info(address=address)['account']['apps-local-state']:
        if(apps_local_data['id']==app_id and not apps_local_data['deleted']):
            for key_value in apps_local_data['key-value']:
                try:
                    key = key_value['key']
                    ##asset id
                    if(key == 'YXNzZXRfaWQ='):
                        return key_value['value']['uint']
                except Exception as e:
                    print(e)

def optin_to_asset(algod_client, address, asset_id, private_key):
    txn = transaction.AssetOptInTxn(address, algod_client.suggested_params(), asset_id)
    signed_txn = txn.sign(private_key)
    algod_client.send_transaction(signed_txn)
    wait_for_confirmation(algod_client, txn.get_txid())

# helper function to compile program source
def compile_program(algod_client, source_code) :
    compile_response = algod_client.compile(source_code.decode('utf-8'))
    return base64.b64decode(compile_response['result'])

def import_teal_source_code_as_binary(file_name):
    with open(file_name, 'r') as f:
        data = f.read()
        return str.encode(data)

# helper function that waits for a given txid to be confirmed by the network
def wait_for_confirmation(algod_client,txid) :
    last_round = algod_client.status().get('last-round')
    txinfo = algod_client.pending_transaction_info(txid)
    while not (txinfo.get('confirmed-round') and txinfo.get('confirmed-round') > 0):
        print("Waiting for txn confirmation...")
        last_round += 1
        algod_client.status_after_block(last_round)
        txinfo = algod_client.pending_transaction_info(txid)
    print("Transaction {} confirmed in round {}.".format(txid, txinfo.get('confirmed-round')))
    return txinfo

if __name__ == "__main__":
    main()
