Casper  (AXA – Impact Token): 
We are using ERC-20 developer library to generate Master (an impact ERC-20 fungible Casper token) and also using Casper smart contracts eco-system to develop a counter for road incidents reported by citizens and complains resolved by police authorities in a specific region which could be shared across citizens and government authorities. Our impact token for citizens create a positive societal behavior and can be used for availing tax benefits, citizen rewards and ecommerce gift cards by Ministry of Road and Transportation. Please visit: https://github.com/seetadev/RoadOps/tree/main/Challenges/Casper/erc20-token-developer and https://github.com/seetadev/RoadOps/tree/main/Challenges/Casper/incidentcounter. Please watch the video at https://drive.google.com/drive/folders/1KvQJdXcWq619OKKJPk37Sb6XzpQzWyji

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
