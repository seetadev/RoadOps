# Resources

- [GitHub Repo](https://github.com/magiclabs/example-cronos)
- [Demo](https://vmgvtk.csb.app/)

# Quick Start

```
$ git clone https://github.com/magiclabs/example-cronos.gi
$ cd example-cronos
$ mv .env.example .env // enter your TEST API Key (from https://dashboard.magic.link)
$ yarn install
$ yarn start
```

# Introduction

## What is Cronos

[Cronos](https://https://cronos.org/) is a blockchain that is interoperable with both the Ethereum and Cosmos ecosystems. It aims to massively scale the Web3 user community by providing builders with the ability to instantly port apps and crypto assets from other chains with low cost, high throughput, and fast finality.

Cronos is interoperable with Ethereum and the Ethereum Virtual Machine (EVM) so smart contracts can easily be depolyed on Cronos without much/any refactoring.

With Magic, developers can connect to the Cronos network by simply specifying the network URL when initiating a Magic instance. This guide will show how you can create a web3-enabled app on Cronos, call smart contracts, and send transactions.

## Connecting to Cronos

In `magic.js`, we will create a `magic` and a `web3` instance.

```js
import { Magic } from "magic-sdk";
import Web3 from "web3";

const customNodeOptions = {
  rpcUrl: "https://evm-t3.cronos.org/", // Cronos testnet URL
  chainId: 338, // Cronos testnet chainId
};

// Setting network to Cronos Testnet
export const magic = new Magic(process.env.REACT_APP_MAGIC_PUBLISHABLE_KEY, {
  network: customNodeOptions,
});

export const web3 = new Web3(magic.rpcProvider);
```

## Viewing User Balance

A simple `web3.eth.getBalance` call is all that is needed to obtain the user's balance.

```js
const fetchBalance = (address) => {
  web3.eth.getBalance(address).then(bal => setBalance(web3.utils.fromWei(bal)))
}

return (
<h1>Balance</h1>
<div className="info">
  {balance.toString().substring(0, 6)} TCRO
</div>
)
```

## Send Transaction

Sending a transaction is also very simple.

To get the gas price, you can use `web3.eth.getGasPrice`.

For the gas limit on Cronos testnet, we have hard-coded 50000.

```js
import { web3 } from "../magic";

const sendTransaction = async () => {
  if (!toAddress || !amount) return;
  disableForm();

  const { transactionHash } = await web3.eth.sendTransaction({
    from: publicAddress,
    to: toAddress,
    value: web3.utils.toWei(amount),
    gas: 50000,
    gasPrice: await web3.eth.getGasPrice(),
  });
  setTxnHash(transactionHash);
  enableForm();
};

return (
  <div className="container">
    <h1>Send Transaction</h1>
    <input
      type="text"
      disabled={disabled}
      value={toAddress}
      onChange={(e) => setToAddress(e.target.value)}
      className="full-width"
      placeholder="To Address"
    />
    <input
      type="text"
      disabled={disabled}
      value={amount}
      onChange={(e) => setAmount(e.target.value)}
      className="full-width"
      placeholder="Amount"
    />
    <button disabled={disabled} ref={sendTxBtnRef} onClick={sendTransaction}>
      Send Transaction
    </button>
  </div>
);
```

## Calling Smart Contracts

The smart contract will need to be deployed to Cronos testnet so that we can interact with it. The contract can be deployed to any EVM compatible chains, just be sure to get the addresses for the contract on each chain. Since we are only deploying to Cronos testnet in this demo we only have one address to record.

```js
const [message, setMessage] = useState('...');
const [newMessage, setNewMessage] = useState('');
const cronosContractAddress = "0x1b9772EaD2F0edA27E0185f8A18aeD3924d45643";
const contract = new web3.eth.Contract(abi, cronosContractAddress);

// Grabbing `message` variable value stored in the smart contract
const fetchContractMessage = () => contract.methods.message().call().then(setMessage);

// Update contract `message` value on the blockchain
const updateContractMessage = async () => {
  if (!newMessage) return;

  // Estimate Gas Limit
  let gasLimit = await contract.methods.update(newMessage).estimateGas({});

  const { transactionHash } = await contract.methods.update(newMessage).send({
    from: publicAddress,
    gas: gasLimit,
    gasPrice: await web3.eth.getGasPrice(),
  });
}

return (
  <h1>Contract Message</h1>
  <div className="info">{message}</div>

  <h1>Update Message</h1>
  <input
    type="text"
    value={newMessage}
    onChange={(e) => setNewMessage(e.target.value)}
    placeholder="New Message" />

  <button onClick={updateContractMessage}>Update</button>
)
```

## Done

That's all there is to it! You've now got an app that allows users to create a wallet with just their email, and connect to the Cronos testnet within your app.
