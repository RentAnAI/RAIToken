#@version 0.3.7

# Staking_Contract.vy

# @title: Staking Contract for GPU Rental Marketplace
# @dev: Manages staking of RAI tokens for participants

# @dev: should consider adding an interface to search for the gpu amounts to decide the minimum to stake. 

from vyper.interfaces import ERC20

# Event for logging staking
event Stake:
    staker: indexed(address)
    amount: uint256

# Event for logging unstaking
event Unstake:
    staker: indexed(address)
    amount: uint256

# State variables
stakingToken: public(address)  # Address of RAI Token Contract
minimumStake: public(uint256)  # Minimum amount to stake, e.g., 1000 RAI
stakes: public(HashMap[address, uint256])  # Map of staked amounts per address

@external
def __init__(_stakingToken: address, _minimumStake: uint256):
    """
    @dev Initialize the staking contract with RAI Token address and minimum stake amount
    """
    self.stakingToken = _stakingToken
    self.minimumStake = _minimumStake

@external
def stake(_amount: uint256):
    """
    @dev Stake RAI tokens into the contract. The tokens must be approved for transfer prior to staking.
    """
    assert _amount >= self.minimumStake, "Staking amount is less than the minimum required"
    ERC20(self.stakingToken).transferFrom(msg.sender, self, _amount)
    self.stakes[msg.sender] += _amount
    log Stake(msg.sender, _amount)

@external
def unstake(_amount: uint256):
    """
    @dev Unstake RAI tokens from the contract.
    """
    assert self.stakes[msg.sender] >= _amount, "Insufficient staked amount"
    self.stakes[msg.sender] -= _amount
    ERC20(self.stakingToken).transfer(msg.sender, _amount)
    log Unstake(msg.sender, _amount)

@external
@view
def getStakedAmount(_staker: address) -> uint256:
    """
    @dev Returns the staked amount of a given staker.
    """
    return self.stakes[_staker]
