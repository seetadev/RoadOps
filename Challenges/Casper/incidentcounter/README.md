We are using Casper to develop a counter smart contract for road incidents in a specific region which could be shared across citizens and government authorities.
Please visit: https://github.com/seetadev/RoadOps/tree/main/Challenges/Casper/incidentcounter

## Usage

### Set up the Rust toolchain
You need the Rust toolchain to develop smart contracts.
```bash
make prepare
```

### Compile smart contracts
Compile WASM files that will be used later.
```bash
make build-contracts
```

### Run tests
You can run integration tests with this command:
```bash
make test
```
