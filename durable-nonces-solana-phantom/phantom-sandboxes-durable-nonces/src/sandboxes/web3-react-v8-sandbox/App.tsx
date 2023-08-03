/**
 * @DEV: If the sandbox is throwing dependency errors, chances are you need to clear your browser history.
 * This will trigger a re-install of the dependencies in the sandbox – which should fix things right up.
 * Alternatively, you can fork this sandbox to refresh the dependencies manually.
 */
import React, { useState, useCallback } from 'react';
import styled from 'styled-components';

import { logProps, TLog } from './types';
import { Logs, Sidebar } from './components';

import { Web3ReactProvider, Web3ReactHooks, useWeb3React } from '@web3-react/core/latest';
import { Connector } from '@web3-react/types/latest';

import allConnections from './utils/connectors';
// =============================================================================
// Web3-React Connector Config
// =============================================================================
const connections: [Connector, Web3ReactHooks][] = allConnections.map(([connector, hooks]) => [connector, hooks]);

// =============================================================================
// Styled Components
// =============================================================================

const StyledApp = styled.div`
  display: flex;
  flex-direction: row;
  height: 100vh;
  @media (max-width: 768px) {
    flex-direction: column;
  }
`;

// =============================================================================
// Typedefs
// =============================================================================

export type SidebarMethods =
  | {
      name: string;
      onClick: (isActive: boolean, isActivating: boolean, connector: Connector) => void;
    }
  | {
      name: string;
      onClick: () => Promise<void>;
    }
  | {
      name: string;
      onClick: () => void;
    };

// =============================================================================
// Hooks
// =============================================================================

export const useLogs = (): logProps => {
  const [logs, setLogs] = useState<TLog[]>([]);

  const createLog = useCallback(
    (log: TLog) => {
      return setLogs((logs) => [...logs, log]);
    },
    [setLogs]
  );

  const clearLogs = useCallback(() => {
    setLogs([]);
  }, [setLogs]);

  return {
    logs,
    createLog,
    clearLogs,
  };
};

const App = React.memo((logs: logProps) => {
  const { connector, hooks } = useWeb3React();

  return (
    <StyledApp>
      <Sidebar logProps={logs} connector={connector} hooks={hooks} />
      <Logs logProps={logs} connector={connector} hooks={hooks} />
    </StyledApp>
  );
});

// =============================================================================
// Wrapper Component
// =============================================================================

const Wrapper = () => {
  const logs = useLogs();

  return (
    <Web3ReactProvider connectors={connections}>
      <App {...logs} />
    </Web3ReactProvider>
  );
};

export default Wrapper;
