# Pyth dapp module to generate dynamic NFT updated by price prediction

# Localnet
copy Pyth oracle account data to local validater
```
$ solana-test-validator -c H6ARHf6YXhGYeQfUzQNGk6rDNnLBQKrenN712K4AQJEG --url https://api.mainnet-beta.solana.com
```
open another terminal to test
```
$ anchor test
or
$ mocha -t 10000 tests/
```