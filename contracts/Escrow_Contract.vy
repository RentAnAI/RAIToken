#@version 0.3.7

# Escrow_Contract.vy

# @title: Escrow Contract for GPU Rental Marketplace
# @dev: Manages the escrow of RAI tokens for rentals

# @dev: Todo: 1)rental orderbooks interface 2)

# Event for logging escrow deposits

event Deposit:
    sender: indexed(address)
    amount: uint256
    rentalId: indexed(uint256)

# Event for logging escrow releases
event Release:
    receiver: indexed(address)
    amount: uint256
    rentalId: indexed(uint256)

Struct escrows:
    rentalId:uint256

# State variables
RaiToken: public(address)  # Address of RAI Token Contract
escrows: public(HashMap[address, uint256[2]]) # Mapping of rentalId to escrow amounts per address

@external
def __init__(_RaiToken: address):
    """
    @dev Initialize the escrow contract with the RAI Token address
    """
    self.RaiToken = _RaiToken

@external
def deposit(_rentalId: uint256, _amount: uint256):
    """
    @dev Deposit RAI tokens into escrow for a specific rental.
    Tokens must be approved for transfer before depositing.
    @dev ToDO_verify _rentalId is eligbile
    """
    ERC20(self.RaiToken).approve(msg.sender, _amount)  
    ERC20(self.RaiToken).transferFrom(msg.sender, self, _amount)
    self.escrows[_rentalId][msg.sender] += _amount
    log Deposit(msg.sender, _amount, _rentalId)

@external
def release(_rentalId: uint256, _receiver: address, _amount: uint256):
    """
    @dev Release escrowed RAI tokens to a receiver after rental completion.
    This should typically be called by a trusted party or after a consensus mechanism.
    """
    assert self.escrows[_rentalId][_receiver] >= _amount, "Insufficient escrowed amount"
    self.escrows[_rentalId][_receiver] -= _amount
    ERC20(self.RaiToken).transfer(_receiver, _amount)
    log Release(_receiver, _amount, _rentalId)

@external
@view
def getEscrowAmount(_rentalId: uint256, _participant: address) -> uint256:
    """
    @dev Returns the escrowed amount for a given rental and participant.
    """
    return self.escrows[_rentalId][_participant]
