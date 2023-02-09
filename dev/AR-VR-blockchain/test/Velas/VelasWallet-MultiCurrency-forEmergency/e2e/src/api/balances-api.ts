import Axios, { AxiosInstance, AxiosRequestConfig } from 'axios';
import { ropsten } from './explorers-api';

export class BalancesAPI {
  axios: AxiosInstance;

  axiosConfig: AxiosRequestConfig;

  constructor() {
    this.axiosConfig = {
      maxRedirects: 0,
      timeout: 10000,
      validateStatus: (status: number): boolean => status < 400,
      params: {
      },
    };
    this.axios = Axios.create(this.axiosConfig);
  }

  async bitcore() {
    const bitcoreRequestURL = 'https://bitcore.testnet.velas.com/api/BTC/testnet/address/myVH5F64jS4gGvjoq4bMouuxQFLxEUmB8U/balance';
    const bitcoreResponse = await this.axios.get(bitcoreRequestURL);
    if (!bitcoreResponse.data.balance) throw new Error(`No balance returned from: ${bitcoreRequestURL}\nResponse data:\n${bitcoreResponse.data}`);
  }

  async apiVelasCom() {
    const apiTestnetVelasURL = 'https://api.testnet.velas.com/rpc';
    const apiTestnetVelasResponse = await this.axios.post(apiTestnetVelasURL, {
      jsonrpc: '2.0',
      id: 1,
      method: 'eth_getBalance',
      params: [
        '0x1201553d1cda7c3bd7abc037a382d958b2674528',
        'latest',
      ],
    });
    if (!apiTestnetVelasResponse.data) throw new Error(`Invalid response from: ${apiTestnetVelasURL}\nResponse data:\n${apiTestnetVelasResponse.data}`);
  }

  async evmExplorer() {
    const evmExplorerTestnetVelasURL = 'https://evmexplorer.testnet.velas.com/rpc';
    const evmExplorerTestnetVelasResponse = await this.axios.post(evmExplorerTestnetVelasURL, {
      jsonrpc: '2.0',
      id: 1,
      method: 'eth_getBalance',
      params: [
        '0x1201553d1cda7c3bd7abc037a382d958b2674528',
        'latest',
      ],
    });
    if (!evmExplorerTestnetVelasResponse.data) throw new Error(`Invalid response from: ${evmExplorerTestnetVelasURL}\nResponse data:\n${evmExplorerTestnetVelasResponse.data}`);
  }

  async explorer() {
    const explorerTestnetVelasURL = 'https://explorer.testnet.velas.com/rpc';
    const explorerTestnetVelasResponse = await this.axios.post(explorerTestnetVelasURL, {
      jsonrpc: '2.0',
      id: 1,
      method: 'eth_getBalance',
      params: [
        '0x1201553d1cda7c3bd7abc037a382d958b2674528',
        'latest',
      ],
    });
    if (!explorerTestnetVelasResponse.data) throw new Error(`Invalid response from: ${explorerTestnetVelasURL}\nResponse data:\n${explorerTestnetVelasResponse.data}`);
  }

  async ethBalance() {
    await ropsten.getaddressBalance('0x9c525b0dbab6cef23ff3caf639e41e2d6cee857d');
  }
}

export default new BalancesAPI();
