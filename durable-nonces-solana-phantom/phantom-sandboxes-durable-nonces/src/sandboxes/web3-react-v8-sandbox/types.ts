import { providers } from 'ethers';

type PhantomEvent = 'connect' | 'disconnect' | 'accountChanged';

type PhantomRequestMethod =
  | 'connect'
  | 'disconnect'
  | 'eth_sendTransaction'
  | 'signMessage';


export type Status = 'success' | 'warning' | 'error' | 'info';

export interface TLog {
  status: Status;
  method?: PhantomRequestMethod | Extract<PhantomEvent, 'accountChanged'>;
  confirmation?: {signature: string, link: string};
  message: string;
  messageTwo?: string;
}
export interface logProps {
  logs: TLog[];
  clearLogs: () => void;
  createLog: (log: TLog) => void;
}

export type Web3Provider = providers.Web3Provider;
