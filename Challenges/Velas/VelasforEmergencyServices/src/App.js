import React from 'react';
import { Button, TextField, Dialog, DialogTitle, DialogContent } from '@material-ui/core';
import Web3 from 'web3';
import StakingContractJson from './StakingContract.json';
import DevelopmentContractJson from './DevelopmentContract.json';

const iframeStyle = {
  width: "100%",
  height: "640px",
};

const walletOrigin = "https://wallet.testnet.velas.com/frame.html";
// const walletOrigin = "http://localhost:8080/main-index.html";
const web3 = new Web3("https://explorer.velas.com/rpc");

// const walletOrigin = "https://walet.velas.com"; prod - not working yet
async function have10000VlxStakes(ethAddress) {
  const stakingContract = new web3.eth.Contract(StakingContractJson, "0x1100000000000000000000000000000000000001", {
    from: ethAddress
  });
  const pools = await stakingContract.methods.getStakerPools(ethAddress, 0, 0).call();
  const stakesString = await Promise.all(
      pools.map((pool) =>
        stakingContract.methods.stakeAmount(pool, ethAddress).call()
      )
  );
  const stakes = stakesString.map(parseFloat);
  const totalStake = stakes.reduce((acc, curr) => curr+acc, 0) / 1e18;
  return totalStake >= 10000;
}

async function tryVote(index/* Valid index from 1 to 5 */, ethAddress) {
  if (!have10000VlxStakes(message.ethAddress)) {
    alert("Sorry, you must stake at least 10000 vlx to be able to vote");
    return;
  }
  const devContract = new web3.eth.Contract(DevelopmentContractJson, "0xd89fCa43728eAa5c306c3148DA32dE8A3Ef2963f", {
    from: message.ethAddress
  });
  const index = 1;
  const transaction = devContract.methods.vote(index).encodeABI();

  iframe.contentWindow.postMessage(JSON.stringify({type: "send", transaction, to: "0xd89fCa43728eAa5c306c3148DA32dE8A3Ef2963f", amount: "1"}), "*");
}

async function getProposal(index, ethAddress) {
  const devContract = new web3.eth.Contract(DevelopmentContractJson, "0xd89fCa43728eAa5c306c3148DA32dE8A3Ef2963f", {
    from: ethAddress
  });
  const proposal = await devContract.methods.getProposalByIndex(index, ethAddress).call();
  /*
  [0] - proposal name
  [1] - proposal description
  [2] - vote count
  [3] - vote weight - ignore for now
  [4] - progress - ignore for now
  [5] - is voted?
  */
  return proposal;
}

function sendQueryAddressUntilReceiveAnswer() {
  if (interval4Address)
      clearInterval(interval4Address);
  if (address) return;
  interval4Address = setInterval(() => {
    if (iframe === null) return;
    iframe.contentWindow.postMessage(JSON.stringify({type: "queryAddress"}), "*");
  }, 500);
}

function processAddressMessage(message) {
  clearInterval(interval4Address);
  if (message.address) {
    // alert(message.address);
    setAddress(message.address);
  }
  if (message.err) {
    alert(message.err);
    setError(new Error(message.err));
    return;
  }
  tryVote(1/*1-5*/);
}

function processTxMessage(message) {
  alert(message.txHash) || setAddress(message.address);
}

function App() {
  const [address, setAddress] = React.useState(null);
  const [error, setError] = React.useState(null);
  const [status, setStatus] = React.useState("loading");
  const iframeSrc = `${walletOrigin}`;
  let interval4Address = null;
  let iframe = null;
  const onMessage = (event) => {
    try {
      const message = JSON.parse(event.data);
      switch(message.type) {
        case "address":
          processAddressMessage(message)
        break;
        case "tx":
          processTxMessage(message)
        break;
      }
    } catch (e) {
      setError(e);
    }
  };
  React.useEffect(() => {
    window.addEventListener("message", onMessage);
    return () => {
      window.removeEventListener("message", onMessage);
    };
  });

  const setIframeRef = (gotIframe) => {
    iframe = gotIframe;
    if (iframe === null) return;
    sendQueryAddressUntilReceiveAnswer();
  };
  return (
    <>
      <iframe ref={setIframeRef} style={iframeStyle} src={iframeSrc} title="Wallet"></iframe>
    </>
  );
}

export default App;
