# Solana Wallet Auth for vehicle maintenance and repair

We are using Solana's wallet adapter to sign messages and verifies
their signatures on the backend, allowing for a lean way to authenticate
users without the need for web2 credentials like email/password combinations
or social providers, in this scenario all you have to do is connect your wallet
and sign interaction messages to be properly authenticated.

## How to run

Backend

```bash
cd wallet-backend
yarn && yarn dev
```

Frontend

```bash
cd wallet-frontend
yarn && yarn dev
```

## Technology stack for this example

Most of the technologies used in this example are production ready,
however, be sure to check them and remember to switch LowDB for a
proper database.

### Backend

- NodeJS, Express, Typescript, LowDB (Local JSON file, only for testing), TweetNaCL.
- GraphQL example coming soon.

### Frontend

- React, Typescript, Vite, Solana-Wallet-Adapter, Tailwind.

## Notes

Validation on the backend happens using the library `tweetnacl`,
but some additional checks were added, like `action` and `message expiration`.

The files you want to check are:

- `@wallet-backend/src/middleware/web3Auth.ts`
- `@wallet-frontend/src/lib/api/web3Posts.ts`

Where `web3Auth.ts` defines a simple, yet powerful authorization middleware that
extracts the authorization headers and validates, then parses the message to perform
some additional checks and the `web3Posts.ts` axios client exemplifies a good set
of UX patterns, like reusing a token for `"skip"` requests (Requests that skip action checks).


