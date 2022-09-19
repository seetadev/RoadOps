import React, { useEffect, useState } from "react";
import { useHistory } from "react-router";
import { magic, web3 } from "../magic";
import { abi } from "../contract/abi.js";
import Loading from "./Loading";
import ContractCall from "./ContractCall";
import SendTransaction from "./SendTransaction";
import Info from "./Info";

export default function Home() {
  const [userMetadata, setUserMetadata] = useState();
  const [balance, setBalance] = useState("...");
  const cronosContractAddress = "0x1b9772EaD2F0edA27E0185f8A18aeD3924d45643";
  const contract = new web3.eth.Contract(abi, cronosContractAddress);
  const [message, setMessage] = useState("...");
  const history = useHistory();

  useEffect(() => {
    // On mount, we check if a user is logged in.
    // If so, we'll retrieve the authenticated user's profile, balance and contract message.
    magic.user.isLoggedIn().then((magicIsLoggedIn) => {
      if (magicIsLoggedIn) {
        magic.user.getMetadata().then((user) => {
          setUserMetadata(user);
          fetchBalance(user.publicAddress);
          fetchContractMessage();
        });
      } else {
        // If no user is logged in, redirect to `/login`
        history.push("/login");
      }
    });
  }, [magic]);

  const fetchBalance = (address) => {
    web3.eth
      .getBalance(address)
      .then((bal) => setBalance(web3.utils.fromWei(bal)));
  };

  const fetchContractMessage = () =>
    contract.methods.message().call().then(setMessage);

  return userMetadata ? (
    <>
      <Info balance={balance} user={userMetadata} magic={magic} />
      <SendTransaction
        web3={web3}
        publicAddress={userMetadata.publicAddress}
        fetchBalance={fetchBalance}
      />
      <ContractCall
        web3={web3}
        contract={contract}
        publicAddress={userMetadata.publicAddress}
        fetchBalance={fetchBalance}
        message={message}
        fetchContractMessage={fetchContractMessage}
      />
    </>
  ) : (
    <Loading />
  );
}
