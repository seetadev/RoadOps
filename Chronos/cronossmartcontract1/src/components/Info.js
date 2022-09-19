import React, { useCallback } from "react";
import { useHistory } from "react-router";

export default function Info({ user, magic, balance }) {
  const history = useHistory();

  const logout = useCallback(() => {
    magic.user.logout().then(() => {
      history.push("/login");
    });
  }, [history]);

  return (
    <>
      <div className="container">
        <h1>Current user: {user.email}</h1>
        <button onClick={logout}>Logout</button>
      </div>

      <div className="container">
        <h1>Network</h1>
        <div className="info">Cronos Testnet</div>
        <h1>Public Address</h1>
        <div className="info">{user.publicAddress}</div>
        <h1>Balance</h1>
        <div className="info">{balance.toString().substring(0, 6)} tCRO</div>
        <div>
          <a href="https://cronos.org/faucet" target="_blank">
            Get Test CRO (tCRO) ↗️
          </a>
        </div>
      </div>
    </>
  );
}
