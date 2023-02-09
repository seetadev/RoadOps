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

from pyteal import *
from algosdk import account, mnemonic

def approval_program():

    arg_0 = Txn.application_args[0]
    arg_1 = Txn.application_args[1]
    arg_2 = Txn.application_args[2]
    arg_3 = Txn.application_args[3]
    arg_4 = Txn.application_args[4]

    acc_1 = Txn.accounts[1]

    subscription_price = Mul(Btoi(arg_1), App.globalGet(Bytes("subscription_price")))
    
    on_creation = Seq([
        App.globalPut(Bytes("unit_name"), arg_0),
        App.globalPut(Bytes("asset_name"), arg_1),
        App.globalPut(Bytes("asset_url"), arg_2),
        App.globalPut(Bytes("subscription_price"), Btoi(arg_3)),
        App.globalPut(Bytes("duration"), Btoi(arg_4)),
        App.globalPut(Bytes("receiver_address"), acc_1),
        Return(Int(1))
    ])

    update_or_delete_application = Seq([
        Assert(Txn.sender() == Global.creator_address()),
        Return(Int(1))
    ])

    update_global_state = Seq([
        Assert(Txn.sender() == Global.creator_address()),
        App.globalPut(arg_1, arg_2),
        Return(Int(1))
    ])

    accept_nft = Seq([
        Assert(App.localGet(Int(0), Bytes("accepted")) == Int(0)),
        Assert(Txn.assets[0] == App.localGet(Int(0), Bytes("asset_id"))),
        InnerTxnBuilder.Begin(),
        InnerTxnBuilder.SetFields({
            TxnField.type_enum: TxnType.AssetTransfer,
            TxnField.asset_receiver: Txn.sender(),
            TxnField.asset_amount: Int(10),
            TxnField.xfer_asset: Txn.assets[0]
        }),
        InnerTxnBuilder.Submit(),
        App.localPut(Int(0), Bytes("accepted"), Int(1)),
        Return(Int(1))
    ])
    
    destroy_nft = Seq([
        Assert(App.localGet(Int(1), Bytes("expiry")) < Global.latest_timestamp()),
        Assert(Txn.assets[0] == App.localGet(Int(1), Bytes("asset_id"))),
        InnerTxnBuilder.Begin(),
        InnerTxnBuilder.SetFields({
            TxnField.type_enum: TxnType.AssetConfig,
            TxnField.config_asset: Txn.assets[0],
            TxnField.config_asset_clawback: Global.current_application_address(),
            TxnField.config_asset_manager: Global.current_application_address()
        }),
        InnerTxnBuilder.Next(),
        InnerTxnBuilder.SetFields({
            TxnField.type_enum: TxnType.AssetTransfer,
            TxnField.asset_sender: Txn.accounts[1],
            TxnField.asset_amount: Int(10),
            TxnField.asset_receiver: Global.current_application_address(),
            TxnField.xfer_asset: Txn.assets[0],
        }),
        InnerTxnBuilder.Next(),
        InnerTxnBuilder.SetFields({
            TxnField.type_enum: TxnType.AssetConfig,
            TxnField.config_asset: Txn.assets[0]
        }),
        InnerTxnBuilder.Submit(),
        Return(Int(1))
    ])

    subscriber_nft = Seq([
        Assert(Global.group_size() == Int(2)),
        Assert(Gtxn[0].receiver() == App.globalGet(Bytes("receiver_address"))),
        Assert(Gtxn[0].amount() == subscription_price),
        Assert(Gtxn[0].type_enum() == TxnType.Payment),
        Assert(Gtxn[1].type_enum() == TxnType.ApplicationCall),
        Assert(Gtxn[1].sender() == Gtxn[0].sender()),
        InnerTxnBuilder.Begin(),
        InnerTxnBuilder.SetFields({
            TxnField.type_enum: TxnType.AssetConfig,
            TxnField.config_asset_total: Int(10),
            TxnField.config_asset_decimals: Int(1),
            TxnField.config_asset_unit_name: App.globalGet(Bytes("unit_name")),
            TxnField.config_asset_name: App.globalGet(Bytes("asset_name")),
            TxnField.config_asset_url: App.globalGet(Bytes("asset_url")),
            TxnField.config_asset_manager: Global.current_application_address(),
            TxnField.config_asset_clawback: Txn.sender()
        }),
        InnerTxnBuilder.Submit(),
        App.localPut(Int(0), Bytes("asset_id"), InnerTxn.created_asset_id()),
        App.localPut(Int(0), Bytes("expiry"), Add(Global.latest_timestamp(), Mul(Btoi(arg_1), App.globalGet(Bytes("duration"))))),
        App.localPut(Int(0), Bytes("accepted"), Int(0)),
        Return(Int(1))
    ])

    program = Cond(
        [Txn.application_id() == Int(0), on_creation],
        [Txn.on_completion() == OnComplete.OptIn, Return(Int(1))],
        [Txn.on_completion() == OnComplete.UpdateApplication, update_or_delete_application],
        [Txn.on_completion() == OnComplete.DeleteApplication, update_or_delete_application],
        [Txn.on_completion() == OnComplete.CloseOut, Return(Int(0))],
        [Txn.on_completion() == OnComplete.ClearState, Return(Int(0))],
        [Txn.application_args[0] == Bytes("update_global_state"), update_global_state],
        [Txn.application_args[0] == Bytes("subscribe"), subscriber_nft],
        [Txn.application_args[0] == Bytes("accept_nft"), accept_nft],
        [Txn.application_args[0] == Bytes("destroy_nft"), destroy_nft],
    )

    return program

def clear_state_program():
    return Int(1) 

with open('nft_subscription_approval.teal', 'w') as f:
    compiled = compileTeal(approval_program(), Mode.Application, version=6)
    f.write(compiled)

with open('nft_subscription_clear_state.teal', 'w') as f:
    compiled = compileTeal(clear_state_program(), Mode.Application, version=6)
    f.write(compiled)
