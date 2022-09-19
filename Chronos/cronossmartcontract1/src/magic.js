import { Magic } from "magic-sdk";
import Web3 from "web3";

/**
 * Cronos Testnet
 */

const customNodeOptions = {
  rpcUrl: "https://evm-t3.cronos.org/", // Cronos testnet URL
  chainId: 338, // Cronos testnet chainId
};

// Setting network to Cronos Testnet
export const magic = new Magic(process.env.REACT_APP_MAGIC_PUBLISHABLE_KEY, {
  network: customNodeOptions,
});

export const web3 = new Web3(magic.rpcProvider);
