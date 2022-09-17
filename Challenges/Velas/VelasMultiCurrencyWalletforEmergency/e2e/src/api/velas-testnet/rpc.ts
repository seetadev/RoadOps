import Axios, { AxiosInstance } from 'axios';
import { axiosConfig } from './axios-config';

type ConfirmedTransaction = {
  blockTime: number,
  err: null | string,
  signature: string,
  slot: number,
}

export class VelasTestnet {
  private axios: AxiosInstance;

  constructor() {
    this.axios = Axios.create(axiosConfig);
  }

  async getConfirmedTransactionsForAddress(address: string, limit = 10): Promise<{ transactions: ConfirmedTransaction[], signatures: string[] }> {
    const response = await this.axios.post('', {
      jsonrpc: '2.0',
      id: '4644c07303da831b36371afedde62d82',
      method: 'getConfirmedSignaturesForAddress2',
      params: [
        address,
        { limit },
      ],
    });

    const transactions: ConfirmedTransaction[] = response.data.result;
    const signatures: string[] = [];

    if (!response.data.result) throw new Error(`Cannot get transactions for address ${address}\n${response.data.error.message}`);
    if (!transactions.length) throw new Error(`No transactions for address ${address}`);

    transactions.forEach((tx) => {
      signatures.push(tx.signature);
    });

    return { transactions: response.data.result, signatures };
  }

  // async getConfirmedTransaction(signature: string): Promise<{ transactions: ConfirmedTransaction[], signatures: string[] }> {
  //   const response = await this.axios.post('', {
  //     jsonrpc: "2.0",

  // ? what is id
  //     id: "364eacdef6f5042e30f3c9d0a79cb0cc",
  //     method: "getConfirmedTransaction",
  //     params:
  //       [
  //         signature,
  //         "jsonParsed"
  //       ]
  //   });

  //   return response.data.result;
  // }
}

export default new VelasTestnet();
