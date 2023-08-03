# Phantom Sandbox 👻

The all-in-one Phantom Mult-Chain Sandbox Monorepo. This react app contains the following sandboxes:

1. [**Solana**](src/sandboxes/sol-sandbox)
2. [**Ethereum**](src/sandboxes/eth-sandbox)
3. [**Multi-Chain**](src/sandboxes/multi-chain-sandbox)
4. [**Solana Wallet Adapter**](src/sandboxes/adapter-sandbox)
5. [**Rainbowkit**](src/sandboxes/rainbowkit-sandbox)
6. [**Wagmi**](src/sandboxes/wagmi-sandbox)

This repository can be used to build the monorepo react app, or standalone react apps for any of the above sandboxes with minimal dependancies.

The react app is hosted on [https://phantom-sandboxes.vercel.app/](https://phantom-sandboxes.vercel.app/)

---

## Prerequisites
Install the following dependancies:
[Node.js and npm](https://nodejs.org/en/download)
[Yarn](https://classic.yarnpkg.com/lang/en/docs/install/#mac-stable)
[React](https://react.dev/learn/installation)

---

## Build Monorepo
To build the monorepo locally:

### Clone the repository
```
git clone https://github.com/0xproflupin/phantom-sandboxes.git
cd phantom-sandboxes
```

### `yarn install`
Installs all dependancies in [`package.json`](package.json)

### `yarn start`

Runs the app in the development mode.\
Open [http://localhost:3000](http://localhost:3000) to view it in the browser.

The page will reload if you make edits.\
You will also see any lint errors in the console.

---

## Bootstrap Standalone Sandboxes
Run the [script](scripts/create-react-app-from-sandbox.sh) to create a react app for any of the available sandboxes with only those dependancies that are required for that sandbox:

For example, to create a react app for the `sol-sandbox` in `/src/sandboxes/
```
yarn create-app sol-sandbox
```

This will create a folder `src/sandbox_react_apps/sol-sandbox_react_app` which will be a standalone react app for the Solana sandbox. Also, all the dependancies of this sandbox will be already installed using the above script.

### Running Standalone Sandboxes
To run the newly created standalone sandbox, run:

```
cd src/sandbox_react_apps/<sandbox-name>_react_app
yarn start
```

This will open up the react app on [http://localhost:3000](http://localhost:3000).

You can follow the same steps to build a standalone react app for any sandbox and bootstap your project!