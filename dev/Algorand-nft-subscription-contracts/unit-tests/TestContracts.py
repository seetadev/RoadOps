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

import unittest, time
from algosdk import mnemonic
import json, random, string
import helper

unittest.TestLoader.sortTestMethodsUsing = None

class TestContract(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.algod_client = helper.SetupClient("purestake")
        cls.funding_addr, cls.funding_acct_mnemonic = helper.GetFundingAccount(cls.algod_client)
        cls.algod_indexer = helper.SetupIndexer("purestake")

        cls.new_acct_addr, cls.new_acct_mnemonic = helper.GenerateAccount()

        print("Generated new account: "+cls.new_acct_addr)
 
        cls.name = ''.join(random.choice(string.ascii_lowercase) for i in range(6))

        cls.app_index = 0

#class DeployNameRegistry(TestContract):
    
    def test_a_deploynameregistry(self):
        
        helper.FundNewAccount(TestContract.algod_client, TestContract.new_acct_addr, 901000, TestContract.funding_acct_mnemonic)    

        print("Funded 1801000 to new account for the purpose of deploying registry")
        print("Funding account: "+TestContract.funding_addr)

        # Set App index
        TestContract.app_index = helper.DeployContract(TestContract.algod_client, TestContract.new_acct_mnemonic)

        print("Deployed contract to APP_ID: "+str(TestContract.app_index))
        time.sleep(5)
        response=TestContract.algod_indexer.applications(TestContract.app_index)
        self.assertEqual(TestContract.app_index, response["application"]["id"])
        self.assertEqual(TestContract.new_acct_addr,response["application"]["params"]["creator"])

    def test_e_set_account_prop(self):

        print("Test 2: Optin to account")
        TestContract.second_account, TestContract.second_account_mnemonic = helper.GenerateAccount()
        helper.FundNewAccount(TestContract.algod_client, TestContract.second_account, 2501000, TestContract.funding_acct_mnemonic)    
        print("Second account generated: "+TestContract.second_account)
        print('Funded second account to optin')
        optin_txn = helper.optin(TestContract.algod_client, TestContract.app_index, TestContract.second_account, mnemonic.to_private_key(TestContract.second_account_mnemonic))

    def test_f_fund_sc(self):

        print("Test 3: Funding SC address")
        
        subscribe = helper.fund_app(TestContract.algod_client, TestContract.app_index, TestContract.funding_addr, mnemonic.to_private_key(TestContract.funding_acct_mnemonic))
        
    
    def test_g_subscribe_to_nft(self):

        print("Test 4: Subscribe to NFT")
        
        subscribe = helper.subscribe(TestContract.algod_client, TestContract.app_index, TestContract.second_account, TestContract.new_acct_addr, mnemonic.to_private_key(TestContract.second_account_mnemonic))
        print('Assrt created and subcribed')

    def test_h_optin_and_accept_asset(self):

        print("Test 5: getting account local state")
        
        asset_id = helper.get_local_state(TestContract.second_account, TestContract.app_index)
        print("Asset ID: ", asset_id)

        print("Opting in to asset id")
        helper.optin_to_asset(TestContract.algod_client, TestContract.second_account, asset_id, mnemonic.to_private_key(TestContract.second_account_mnemonic))
        print("Successfully opted in to asset by second account")

        print("Accepting the nft")
        helper.accept_nft(TestContract.algod_client, TestContract.app_index, TestContract.second_account, mnemonic.to_private_key(TestContract.second_account_mnemonic))
    
    def test_i_destroy_asset(self):

        print("Test 6: destroying the asset")    
        helper.destroy_nft(TestContract.algod_client, TestContract.app_index, TestContract.funding_addr, TestContract.second_account, mnemonic.to_private_key(TestContract.funding_acct_mnemonic))
   

# TODO: See where tearDown goes, class or outside
def tearDownClass(self) -> None:
    # TODO: clear all variables?
    return super().tearDown()

if __name__ == '__main__':
    unittest.main()
