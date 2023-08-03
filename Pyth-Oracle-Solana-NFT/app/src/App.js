import { Container, Paper } from '@material-ui/core';
import { WalletAdapterNetwork } from '@solana/wallet-adapter-base';
import { useWallet, ConnectionProvider, WalletProvider } from '@solana/wallet-adapter-react';
import { Connection, PublicKey } from '@solana/web3.js';
import {
  Program, Provider, web3
} from '@project-serum/anchor';
import {
  WalletModalProvider, WalletMultiButton
} from '@solana/wallet-adapter-react-ui';
import { Button } from '@solana/wallet-adapter-react-ui/lib/Button';
import {
  getLedgerWallet,
  getPhantomWallet,
  getSlopeWallet,
  getSolflareWallet,
  getSolletExtensionWallet,
  getSolletWallet,
  getTorusWallet
} from '@solana/wallet-adapter-wallets';
import { clusterApiUrl } from '@solana/web3.js';
import React, { useMemo } from 'react';
import './App.css';
import idl from './idl.json';
require('@solana/wallet-adapter-react-ui/styles.css');
const { SystemProgram, Keypair } = web3;

const opts = {
  preflightCommitment: "processed"
}
const programID = new PublicKey(idl.metadata.address);
const oracleSolUsd = {
  isSigner: false,
  isWritable: false,
  pubkey: new PublicKey("J83w4HKfqxwcq3BEMMkPFSppX3gqekLyLJBexebFVkix"),
};

function App() {
  const wallet = useWallet();
  async function getProvider() {
    /* create the provider and return it to the caller */
    /* network set to local network for now */

    const network = "http://127.0.0.1:8899";
    const connection = new Connection(network, opts.preflightCommitment);

    const provider = new Provider(
      connection, wallet, opts.preflightCommitment,
    );
    return provider;
  }

  async function handleCreate() {
    const baseAccount = Keypair.generate();
    const provider = await getProvider();
    const program = new Program(idl, programID, provider);
    console.log(baseAccount.publicKey);
    try {
      /* interact with the program via rpc */
      await program.rpc.create(provider.wallet.publicKey, {
        accounts: {
          tradingAccount: baseAccount.publicKey,
          user: provider.wallet.publicKey,
          systemProgram: SystemProgram.programId,
        },
        signers: [baseAccount],
        remainingAccounts: [oracleSolUsd]
      });

      const account = await program.account.tradingAccount.fetch(baseAccount.publicKey);
      console.log('account: ', account);
    } catch (err) {
      console.log("Transaction error: ", err);
    }

  }
  return (

    <div className="App">
      <Container maxWidth='sm'>
        <Paper>
          <WalletMultiButton />
          <Button onClick={handleCreate}> Create</Button>
        </Paper>
      </Container>

    </div>
  );
}

function AppWithProvider() {
  const network = WalletAdapterNetwork.Devnet;
  const endpoint = useMemo(() => clusterApiUrl(network), [network]);

  // You can also provide a custom RPC endpoint

  // @solana/wallet-adapter-wallets includes all the adapters but supports tree shaking --
  // Only the wallets you configure here will be compiled into your application
  const wallets = useMemo(() => [
    getPhantomWallet(),
    getSlopeWallet(),
    getSolflareWallet(),
    getTorusWallet({
      options: { clientId: 'Get a client ID @ https://developer.tor.us' }
    }),
    getLedgerWallet(),
    getSolletWallet({ network }),
    getSolletExtensionWallet({ network }),
  ], [network]);
  return (
    <ConnectionProvider endpoint={endpoint}>
      <WalletProvider wallets={wallets} autoConnect>
        <WalletModalProvider>
          <App />
        </WalletModalProvider>
      </WalletProvider>
    </ConnectionProvider>
  )
}
export default AppWithProvider;
