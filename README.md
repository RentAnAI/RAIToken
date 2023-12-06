
# GPU Rental Marketplace

## Introduction

Welcome to GPU Rental Marketplace, your all-in-one solution for GPU rental services. 
We've created a utility token named RAI, with a total supply of 888 million, designed 
exclusively for paying for GPU instances. Renters can submit offers specifying GPU type, 
hourly rates, SSH login details, bandwidth, preinstalled LLMS, and any additional information 
they find relevant.

To participate as renters or providers, a stake of 1000 tokens is required. The utility token, 
RAI, ensures a secure transaction environment. We've implemented robust security measures and a 
secure escrow system to safeguard the tokens paid for GPU instances. These tokens will only be 
released upon receiving positive feedback about the GPU's performance during the working hour.

Join us in revolutionizing GPU rental services with transparency, security, and user satisfaction 
at the core of our marketplace.

## Features

- **RAI Toke - Deployed:** RAI token contract, handling the creation, issuance, and management 
of the utility token.

- **Stake Contract - Deployed:** Manages the staking mechanism for both renters and providers, 
ensuring they stake 1000 RAI tokens to participate.

- **Escrow Contract - Working-in-progress:** This contract handles the escrow system for holding 
and releasing tokens based on the successful completion of GPU rentals.

- **Marketplace Contract - Working-in-progress:** Manages the listing of GPUs, making and 
accepting offers, and the overall rental process.

## Getting Started

### Install Brownie

[Install Brownie](https://eth-brownie.readthedocs.io/en/stable/install.html)

### Creating a New Project

```bash
brownie init
```

The first step to using Brownie is to initialize a new project. 

### or Creating a Project from an ERC-20 Template

```bash
brownie bake token
```

This creates a new folder token/ and deploys the project inside it.

### Brownie Compile

To compile all of the contract sources within the contracts/ subfolder of a project:

```bash
brownie compile 
```

### Brownie Console

The console is useful when you want to interact directly with contracts deployed on a 
non-local chain or for quick testing as you develop. It’s also a great starting point to 
familiarize yourself with Brownie’s functionality.

The console feels very similar to a regular Python interpreter. From inside a project directory, 
load it by typing:

```bash
brownie console --network sepolia
```

It specifies the network as sepolia. It's also common to test on a local forked mainnet.

```bash
brownie console --network mainnet-fork
```

Then, try deploy a contract directly:

```python
token = Token.deploy("RAI Token", "RAI", 18, 888000000*10**18, {'from': accounts[0]})
```

After a token contract is deployed, a balance of `888000000*10**18` is assigned to `accounts[0]`. 
Then you can interact with the contract in the console:

```python
token
```

```python
token.balanceOf(accounts[0])
```

```python
token.transfer(accounts[1], 1e18, {'from': accounts[0]})
```

you can also run the Staking_deploy.py script, 
it will delpoy Stake_Contract.vy according to Staking_deploy.py script:

```python
run('Staking_deploy.py')
```

## Testing

To run the tests:

```bash
brownie test 
```

## Resources

[Generate accounts in brownie](https://eth-brownie.readthedocs.io/en/stable/account-management.html#generating-a-new-account)
[Infura API Token]
If you decide to use Infura as your provider, you will also need an Infura Project Key.
```bash
export WEB3_INFURA_PROJECT_ID='Your API Token'
```
[Etherscan API Token]
To use the API source verification feature, you must provide an Etherscan API token.
```bash
export ETHERSCAN_TOKEN='YourToken'
```