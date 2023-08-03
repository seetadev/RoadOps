const assert = require("assert");
const anchor = require("@project-serum/anchor");
// const { test } = require("mocha");
// const { expect } = require("chai");
const { SystemProgram, PublicKey } = anchor.web3;

describe('pythaplex', () => {

  const oracleSolUsd = {
    isSigner: false,
    isWritable: false,
    pubkey: new PublicKey("J83w4HKfqxwcq3BEMMkPFSppX3gqekLyLJBexebFVkix"),
  };

  const oracleAdaUsd = {
    isSigner: false,
    isWritable: false,
    pubkey: new PublicKey("EdVCmQ9FSPcVe5YySXDPCRmc8aDQLKJ9xvYBMZPie1Vw"),
  }

  // Configure the client to use the local cluster.
  const provider = anchor.Provider.env();
  anchor.setProvider(provider);
  const program = anchor.workspace.Pythaplex;

  it('Create a trading account', async () => {
    const tradingAccount = anchor.web3.Keypair.generate();
    await program.rpc.create(
      provider.wallet.publicKey,
      {
        accounts: {
          tradingAccount: tradingAccount.publicKey,
          user: provider.wallet.publicKey,
          systemProgram: SystemProgram.programId,
        },
        remainingAccounts: [oracleSolUsd],
        signers: [tradingAccount],
      }
    );
    console.log(await program.account.tradingAccount.fetch(tradingAccount.publicKey))
  });

  it('Open long position', async () => {
    const tradingAccount = anchor.web3.Keypair.generate();
    await program.rpc.create(
      provider.wallet.publicKey,
      {
        accounts: {
          tradingAccount: tradingAccount.publicKey,
          user: provider.wallet.publicKey,
          systemProgram: SystemProgram.programId,
        },
        remainingAccounts: [oracleSolUsd],
        signers: [tradingAccount],
      }
    );
    await program.rpc.open(
      {
        accounts: {
          tradingAccount: tradingAccount.publicKey,
          authority: provider.wallet.publicKey,
        },
        remainingAccounts: [oracleSolUsd],
      }
    );
  });

  it('Open long position but not the same oracle', async () => {
    const tradingAccount = anchor.web3.Keypair.generate();
    await program.rpc.create(
      provider.wallet.publicKey,
      {
        accounts: {
          tradingAccount: tradingAccount.publicKey,
          user: provider.wallet.publicKey,
          systemProgram: SystemProgram.programId,
        },
        remainingAccounts: [oracleSolUsd],
        signers: [tradingAccount],
      }
    );
    try {
      await program.rpc.open(
        {
          accounts: {
            tradingAccount: tradingAccount.publicKey,
            authority: provider.wallet.publicKey,
          },
          remainingAccounts: [oracleAdaUsd],
        }
      );
    } catch(err) {
      assert.equal(
        err.toString(),
        "using different oracle"
      );
    }
  });

  it('Open and close a position', async () => {
    const tradingAccount = anchor.web3.Keypair.generate();
    await program.rpc.create(
      provider.wallet.publicKey,
      {
        accounts: {
          tradingAccount: tradingAccount.publicKey,
          user: provider.wallet.publicKey,
          systemProgram: SystemProgram.programId,
        },
        remainingAccounts: [oracleSolUsd],
        signers: [tradingAccount],
      }
    );
    await program.rpc.open(
      {
        accounts: {
          tradingAccount: tradingAccount.publicKey,
          authority: provider.wallet.publicKey,
        },
        remainingAccounts: [oracleSolUsd],
      }
    );
    await program.rpc.close(
      {
        accounts: {
          tradingAccount: tradingAccount.publicKey,
          authority: provider.wallet.publicKey,
        },
        remainingAccounts: [oracleSolUsd],
      }
    );
  });

  it('Close a not open position', async () => {
    const tradingAccount = anchor.web3.Keypair.generate();
    await program.rpc.create(
      provider.wallet.publicKey,
      {
        accounts: {
          tradingAccount: tradingAccount.publicKey,
          user: provider.wallet.publicKey,
          systemProgram: SystemProgram.programId,
        },
        remainingAccounts: [oracleSolUsd],
        signers: [tradingAccount],
      }
    );
    try {
      await program.rpc.close(
        {
          accounts: {
            tradingAccount: tradingAccount.publicKey,
            authority: provider.wallet.publicKey,
          },
          remainingAccounts: [oracleSolUsd],
        }
      );
    } catch(err) {
      assert.equal(
        err.toString(),
        "position already closed"
      );
    }
  });
});

