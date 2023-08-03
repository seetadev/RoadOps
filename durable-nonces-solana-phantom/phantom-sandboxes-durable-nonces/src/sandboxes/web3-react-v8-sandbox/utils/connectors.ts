// connectors.ts
import { initializeConnector, Web3ReactHooks } from '@web3-react/core/latest'
import { Connector, Web3ReactStore } from '@web3-react/types/latest'
import { Phantom } from 'web3-react-phantom'

const phantom = initializeConnector<Phantom>((actions) => new Phantom({ actions }))

const connectors: [Connector, Web3ReactHooks, Web3ReactStore][] = [phantom]

export default connectors