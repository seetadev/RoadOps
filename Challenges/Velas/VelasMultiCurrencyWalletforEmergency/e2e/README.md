# Prepare

### Install modules
`npm i`

### Run wallet*
*Only required for running tests on localhost.

Build and run wallet: `npm run wallet-start`.

More about wallet start in web-wallet/README.md.

# Run tests
`npx playwright test <path or test name>`

e.g. `npx playwright test src/tests/auth.test.ts` or `npx playwright test auth`

##### Run all tests:
`npm test`

# Configuration
`ENVIRONMENT`

*(refers to where the tests are run)*

Available options: 'local', 'devnet', 'testnet', 'prod'

Default value: 'local' (127.0.0.1)


`NETWORK`

*(refers to the network the tests are run on)*

Available options: 'devnet', 'testnet', 'mainnet'

Default value: 'testnet'

So, when you don't pass any params `http://127.0.0.1:8080/main-index.html` is used.


### CI/CD

#### Concurrency
There are several concurrency levels set up:
1. E.g.

```
group: js-wallet-e2e-tests-${{github.event.pull_request.number}}
cancel-in-progress: true
```

Means only one testrun could exist per the same Pull Request (and any future push will cancel previous runs).
The purpose: if PR is uupdated with new commit - previous testrun results does not matter and new one should be executed with updated codebase.

1. E.g. 
```
group: web-wallet-e2e-tests-staking
cancel-in-progress: false
```

Means only one testrun could exist for current test type (staking tests in example). And future runs will be waiting.
The purpose of that is to prevent multiple testsruns of the same type to be executed in parallel. Because tests interact with app state (e.g. create/delete staking accounts). So only one interaction should be done at a time.


#### Debug
##### Enabling debug window
Add PWDEBUG=1 before your test script, e.g.

`PWDEBUG=1 npx playwright test`

##### Enable playwright logs

`DEBUG=pw:api`

### Allure
`allure generate ./allure-results --clean && allure open ./allure-report`


### LINTER
`npm run lint`

