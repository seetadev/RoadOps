import React from 'react';
import { BrowserRouter as Router, Route, Routes } from 'react-router-dom';
import { SolSandbox } from './sandboxes/sol-sandbox';
import { EthSandbox } from './sandboxes/eth-sandbox';
import { MultiChainSandbox } from './sandboxes/multi-chain-sandbox';
import { SolAdapterSandbox } from './sandboxes/adapter-sandbox';
import { Web3ReactV6Sandbox } from './sandboxes/web3-react-v6-sandbox';
import { Web3ReactV8Sandbox } from './sandboxes/web3-react-v8-sandbox';
import { RainbowKitSandbox } from './sandboxes/rainbowkit-sandbox';
import { ExperimentalSandbox } from './sandboxes/experimental-sandbox';
import { WagmiSandbox } from './sandboxes/wagmi-sandbox';

function App() {
  return (
    <Router>
      <Routes>
        <Route index element={<SolSandbox />} />
        <Route path="/sol-sandbox" element={<SolSandbox />} />
        <Route path="/eth-sandbox" element={<EthSandbox />} />
        <Route path="/multi-chain-sandbox" element={<MultiChainSandbox />} />
        <Route path="/sol-adapter-sandbox" element={<SolAdapterSandbox />} />
        <Route path="/web3-react-v6-sandbox" element={<Web3ReactV6Sandbox />} />
        <Route path="/web3-react-v8-sandbox" element={<Web3ReactV8Sandbox />} />
        <Route path="/rainbowkit-sandbox" element={<RainbowKitSandbox />} />
        <Route path="/wagmi-sandbox" element={<WagmiSandbox/>} />
        <Route path="/experimental-sandbox" element={<ExperimentalSandbox />} />
      </Routes>
    </Router>
  );
}

export default App;