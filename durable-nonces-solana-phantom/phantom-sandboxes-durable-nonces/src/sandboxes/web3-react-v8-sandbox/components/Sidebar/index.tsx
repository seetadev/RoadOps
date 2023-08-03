import React, {  } from 'react';
import styled from 'styled-components';
import { NavLink } from 'react-router-dom';
import { Buffer } from 'buffer';

import { GRAY, REACT_GRAY, PURPLE, WHITE, DARK_GRAY } from '../../constants';

import { hexToRGB } from '../../utils';

import Button from '../Button';
import { Web3ReactSelectedHooks } from '@web3-react/core/latest';
import { Connector } from '@web3-react/types/latest';
import { logProps } from '../../types';
import { Web3Provider } from '@ethersproject/providers';
import { parseEther, toHex } from 'viem';

// =============================================================================
// Styled Components
// =============================================================================

const Main = styled.main`
  position: relative;
  flex: 1;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  padding: 20px;
  align-items: center;
  background-color: ${REACT_GRAY};
  overflow-y: auto;
  -webkit-overflow-scrolling: touch;
  max-height: 100vh;
  > * {
    margin-bottom: 10px;
  }
  @media (max-width: 768px) {
    width: 100%;
    height: auto;
  }
`;

const Body = styled.div`
  display: flex;
  flex-direction: column;
  align-items: center;
  button {
    margin-bottom: 15px;
  }
`;

const Link = styled.a.attrs({
  href: 'https://phantom.app/',
  target: '_blank',
  rel: 'noopener noreferrer',
})`
  display: flex;
  flex-direction: column;
  align-items: flex-end;
  text-decoration: none;
  margin-bottom: 30px;
  padding: 5px;
  &:focus-visible {
    outline: 2px solid ${hexToRGB(GRAY, 0.5)};
    border-radius: 6px;
  }
`;

const Pre = styled.pre`
  margin-bottom: 5px;
`;

const Badge = styled.div`
  margin: 0;
  padding: 10px;
  width: 100%;
  color: ${PURPLE};
  background-color: ${hexToRGB(PURPLE, 0.2)};
  font-size: 14px;
  border-radius: 6px;
  @media (max-width: 400px) {
    width: 280px;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
  }
  @media (max-width: 320px) {
    width: 220px;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
  }
  ::selection {
    color: ${WHITE};
    background-color: ${hexToRGB(PURPLE, 0.5)};
  }
  ::-moz-selection {
    color: ${WHITE};
    background-color: ${hexToRGB(PURPLE, 0.5)};
  }
`;

const Divider = styled.div`
  border: 1px solid ${DARK_GRAY};
  height: 1px;
  margin: 20px 0;
`;

const Tag = styled.p`
  text-align: center;
  color: ${GRAY};
  a {
    color: ${PURPLE};
    text-decoration: none;
    ::selection {
      color: ${WHITE};
      background-color: ${hexToRGB(PURPLE, 0.5)};
    }
    ::-moz-selection {
      color: ${WHITE};
      background-color: ${hexToRGB(PURPLE, 0.5)};
    }
  }
  @media (max-width: 320px) {
    font-size: 14px;
  }
  ::selection {
    color: ${WHITE};
    background-color: ${hexToRGB(PURPLE, 0.5)};
  }
  ::-moz-selection {
    color: ${WHITE};
    background-color: ${hexToRGB(PURPLE, 0.5)};
  }
`;

const NavigationLink = styled(NavLink)`
  display: block;
  color: ${GRAY};
  text-decoration: none;
  margin-bottom: 5px;
  font-size: 14px;
  padding: 8px;
  width: 100%;
  background-color: ${hexToRGB(PURPLE, 0.2)};
  border-radius: 6px;
  box-sizing: border-box;
  text-align: center;

  &.active {
    font-weight: bold;
    color: ${PURPLE};
  }

  &:hover {
    color: ${PURPLE};
  }
`;

const MenuButton = styled.button`
  margin-bottom: 10px;
  padding: 8px 12px;
  width: 200px;
  background-color: ${PURPLE};
  color: ${WHITE};
  border: none;
  border-radius: 6px;
  cursor: pointer;
  &:hover {
    background-color: ${hexToRGB(PURPLE, 0.8)};
  }
`;

const MenuContainer = styled.div`
  display: flex;
  flex-direction: column;
  margin-bottom: 15px;
  width: 200px;
`;

const Menu = styled.div``;

// =============================================================================
// Constants
// =============================================================================

const message = 'To avoid digital dognappers, sign below to authenticate with CryptoCorgis.';
const msg = `0x${Buffer.from(message, 'utf8').toString('hex')}`;

// =============================================================================
// Main Component
// =============================================================================

const Sidebar = React.memo(
  ({ connector, hooks, logProps }: { connector: Connector; hooks: Web3ReactSelectedHooks; logProps: logProps }) => {
    const { useSelectedAccount, useSelectedIsActive, useSelectedIsActivating } = hooks;
    const isActivating = useSelectedIsActivating(connector);
    const isActive = useSelectedIsActive(connector);
    const account = useSelectedAccount(connector);
    const [menuOpen, setMenuOpen] = React.useState(false);
    const { createLog } = logProps;

    const toggleMenu = () => {
      setMenuOpen(!menuOpen);
    };
    const signMessage = async () => {
      const sig = await connector?.provider.request({
        method: 'personal_sign',
        params: [msg, account, message],
      });
      createLog({
        status: 'success',
        method: 'signMessage',
        message: `Successfully signed Message: ${sig}`,
      });
    };
    const sendTransaction = async () => {
     const provider = new Web3Provider(window?.phantom?.ethereum) 
      try {
        const signer = provider.getSigner();
        const tx = {
          gasLimit: toHex(100000),
          to: '0x0000000000000000000000000000000000000000',
          value: parseEther('0.000000000000000001'), // 1 wei
        };
        const pendingHash = await signer.sendTransaction(tx);
        createLog({
          status: 'info',
          method: 'eth_sendTransaction',
          message: `sending TX: ${pendingHash.hash}`,
        });
        createLog({
          status: 'info',
          method: 'eth_sendTransaction',
          message: `pending....this could take up to 30 seconds`,
        });
        const finalizedHash = await pendingHash.wait(1);
        createLog({
          status: 'success',
          method: 'eth_sendTransaction',
          message: `successfully burned 1 wei of ETH ${finalizedHash.blockHash}`,
        });
      } catch (error) {
        createLog({
          status: 'error',
          method: 'eth_sendTransaction',
          message: error.message
        });
      }
    };

    const connectedMethods = [
      {
        name: 'Sign message',
        onClick: signMessage,
      },
      {
        name: 'Send transaction (burn 1 wei on Goerli)',
        onClick: sendTransaction,
      },
    ];
    const handleToggleConnect = () => {
      if (isActive) {
        if (connector?.deactivate) {
          void connector.deactivate();
          createLog({
            status: 'success',
            method: 'disconnect',
            message: 'wallet disconnected',
          });
        } else {
          void connector.resetState();
          createLog({
            status: 'success',
            method: 'disconnect',
            message: 'wallet disconnected',
          });
        }
      } else if (!isActivating) {
        createLog({
          status: 'info',
          method: 'connect',
          message: 'connecting...',
        });
        Promise.resolve(connector.activate(5)) // 5 is goerli chainID
          .catch((e) => {
            connector.resetState();
            createLog({
              status: 'error',
              method: 'connect',
              message: e.message,
            });
          });
        createLog({
          status: 'success',
          method: 'connect',
          message: `successfully connected to app!`,
        });
      }
    };

    return (
      <Main>
        <Body>
          <Menu>
            <MenuButton onClick={toggleMenu}>Sandboxes</MenuButton>
            {menuOpen && (
              <MenuContainer>
                <NavigationLink to="/sol-sandbox">Solana Sandbox</NavigationLink>
                <NavigationLink to="/eth-sandbox">Ethereum Sandbox</NavigationLink>
                <NavigationLink to="/multi-chain-sandbox">Multi-Chain Sandbox</NavigationLink>
                <NavigationLink to="/sol-adapter-sandbox">Solana Adapter Sandbox</NavigationLink>
                <NavigationLink to="/rainbowkit-sandbox">Rainbowkit Sandbox</NavigationLink>
                <NavigationLink to="/wagmi-sandbox">Wagmi Sandbox</NavigationLink>
                <NavigationLink to="/web3-react-v6-sandbox">Web3 React V6 Sandbox</NavigationLink>
                <NavigationLink to="/web3-react-v8-sandbox">Web3 React V8 Sandbox</NavigationLink>
                <NavigationLink to="/experimental-sandbox">Experimental Sandbox</NavigationLink>
              </MenuContainer>
            )}
          </Menu>
          <Link>
            <img src="/images/phantom-icon-purple.png" alt="Phantom" width="75" />
          </Link>
          {isActive ? (
            // connected
            <>
              <div>
                <Pre>Connected as</Pre>
                <Badge>{account}</Badge>
                <Divider />
              </div>
              <Button onClick={handleToggleConnect}>{isActive ? 'Disconnect' : 'Connect'}</Button>
              {connectedMethods.map((method, i) => (
                <Button key={`${method.name}-${i}`} onClick={method.onClick}>
                  {method.name}
                </Button>
              ))}
            </>
          ) : (
            // not connected
            <>
              <Button onClick={handleToggleConnect}>{isActive ? 'Disconnect' : 'Connect'}</Button>
            </>
          )}
        </Body>
        {/* 😊 💕  */}
        <Tag>
          Made with{' '}
          <span role="img" aria-label="Red Heart Emoji">
            ❤️
          </span>{' '}
          by the <a href="https://phantom.app">Phantom</a> team
        </Tag>
      </Main>
    );
  }
);

export default Sidebar;
