import React from "react";

import { AccountBalancePair, Connection } from "@velas/web3";
import { useCluster, ClusterStatus, Cluster } from "./cluster";
import { reportError } from "utils/sentry";

export enum Status {
  Idle,
  Disconnected,
  Connecting,
}

type RichLists = {
  total: AccountBalancePair[];
  circulating: AccountBalancePair[];
  nonCirculating: AccountBalancePair[];
};

type State = RichLists | Status | string;

type Dispatch = React.Dispatch<React.SetStateAction<State>>;
const StateContext = React.createContext<State | undefined>(undefined);
const DispatchContext = React.createContext<Dispatch | undefined>(undefined);

type Props = { children: React.ReactNode };
export function RichListProvider({ children }: Props) {
  const [state, setState] = React.useState<State>(Status.Idle);
  const { status: clusterStatus, cluster, url } = useCluster();

  React.useEffect(() => {
    if (state !== Status.Idle) {
      switch (clusterStatus) {
        case ClusterStatus.Connecting: {
          setState(Status.Disconnected);
          break;
        }
        case ClusterStatus.Connected: {
          fetch(setState, cluster, url);
          break;
        }
      }
    }
  }, [clusterStatus, cluster, url]); // eslint-disable-line react-hooks/exhaustive-deps

  return (
    <StateContext.Provider value={state}>
      <DispatchContext.Provider value={setState}>
        {children}
      </DispatchContext.Provider>
    </StateContext.Provider>
  );
}

async function fetch(dispatch: Dispatch, cluster: Cluster, url: string) {
  dispatch(Status.Connecting);

  try {
    const connection = new Connection(url, "finalized");

    const [total, circulating, nonCirculating] = (
      await Promise.all([
        connection.getLargestAccounts(),
        connection.getLargestAccounts({ filter: "circulating" }),
        connection.getLargestAccounts({ filter: "nonCirculating" }),
      ])
    ).map((response) => response.value);

    // Update state if still connecting
    dispatch((state) => {
      if (state !== Status.Connecting) return state;
      return { total, circulating, nonCirculating };
    });
  } catch (err) {
    if (cluster !== Cluster.Custom) {
      reportError(err, { url });
    }
    dispatch("Failed to fetch top accounts");
  }
}

export function useRichList() {
  const state = React.useContext(StateContext);
  if (state === undefined) {
    throw new Error(`useRichList must be used within a RichListProvider`);
  }
  return state;
}

export function useFetchRichList() {
  const dispatch = React.useContext(DispatchContext);
  if (!dispatch) {
    throw new Error(`useFetchRichList must be used within a RichListProvider`);
  }

  const { cluster, url } = useCluster();
  return React.useCallback(() => {
    fetch(dispatch, cluster, url);
  }, [dispatch, cluster, url]);
}
