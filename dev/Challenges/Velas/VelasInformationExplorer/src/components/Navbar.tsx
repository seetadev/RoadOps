import React from "react";
import Logo from "img/logos-solana/dark-explorer-logo.svg";
import { clusterPath } from "utils/url";
import { Link, NavLink } from "react-router-dom";
import { ClusterStatusButton } from "components/ClusterStatusButton";

export function Navbar() {
  // TODO: use `collapsing` to animate collapsible navbar
  const [collapse, setCollapse] = React.useState(false);
  
  return (
    <nav className="navbar navbar-expand-md navbar-light">
      <div className="container">
        <Link to={clusterPath("/")}>
          <img src={Logo} height="30" alt="Velas Native Explorer" />
        </Link>

        <button
          className="navbar-toggler"
          type="button"
          onClick={() => setCollapse((value) => !value)}
        >
          <span className="navbar-toggler-icon"></span>
        </button>

        <div
          className={`collapse navbar-collapse ml-auto mr-4 ${collapse ? "show" : ""
            }`}
        >
          <ul className="navbar-nav mr-auto tabs">
            <li className="nav-item">
              <NavLink className="nav-link" to={clusterPath("/")} exact>
                Cluster Stats
              </NavLink>
            </li>
            <li className="nav-item">
              <NavLink className="nav-link" to={clusterPath("/supply")}>
                Supply
              </NavLink>
            </li>
            <li className="nav-item">
              <NavLink className="nav-link" to={clusterPath("/tx/inspector")}>
                Inspector
              </NavLink>
            </li>
            <li className="nav-item">
              <a className="nav-link url-link" href="https://velasvalidators.com" target="_blank" rel="noreferrer">
              velasvalidators.com
              </a>
            </li>
            <li className="nav-item">
              <a className="nav-link url-link" href="https://velasity.com/" target="_blank" rel="noreferrer">
              velasity.com
              </a>
            </li>
            <li className="nav-item">
              <a className="nav-link url-link" href="https://evmexplorer.velas.com/" target="_blank" rel="noreferrer">
                EVM Explorer
              </a>
            </li>
          </ul>
        </div>

        <div className="d-none d-md-block">
          <ClusterStatusButton />
        </div>
      </div>
    </nav>
  );
}
