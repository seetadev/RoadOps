from algosdk.constants import microalgos_to_algos_ratio
from algosdk.v2client import indexer

def myindexer():
    algod_address = "https://testnet-algorand.api.purestake.io/idx2"
    algod_token = "3qxbpBOG8f4pUAbnRcv9ERt5HA9iS5j3D1OuLpn7"
    headers = {
        "X-API-Key": algod_token,
    }
    return indexer.IndexerClient("", algod_address, headers)

def get_transactions(address):
    """Returns a list of transactions related to the given address"""

    response = myindexer().search_transactions(address=address, txn_type="pay")
    txns = []
    for txn in response["transactions"]:
        sender = txn["sender"]
        fee = txn["fee"]

        amount = txn["payment-transaction"]["amount"]
        if sender == address:

            # if the current account is the sender, add fee and display transaction as negative
            amount += fee
            amount *= -1
            other_address = txn["payment-transaction"]["receiver"]
        else:
            other_address = sender

        amount /= microalgos_to_algos_ratio

        txns.append({"amount": amount, "address": other_address})
    return txns
def get_assets(address):
    """Returns a list of assets that have been created by the given address"""

    response = myindexer().search_assets(creator=address)
    assets = response["assets"]
    return assets