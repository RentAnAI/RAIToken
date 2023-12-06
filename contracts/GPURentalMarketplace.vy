#@version ^0.3.7

# GPURentalMarketplace contract
struct GPU:
    owner: address
    hourly_rate: uint256
    location: string[32]
    performance: uint256
    usage_history: uint256

struct Rental:
    renter: address
    gpu: GPU
    start_time: timestamp
    end_time: timestamp
    escrow: uint256

@public
def __init__():
    self.gpus: map(address, GPU) = {}
    self.rentals: map(address, Rental) = {}

@public
@payable
def add_gpu(hourly_rate: uint256, location: string[32], performance: uint256):
    self.gpus[msg.sender] = GPU({
        owner: msg.sender,
        hourly_rate: hourly_rate,
        location: location,
        performance: performance,
        usage_history: 0
    })

@public
def get_gpu(gpu_owner: address) -> GPU:
    return self.gpus[gpu_owner]

@public
def update_gpu_hourly_rate(new_rate: uint256):
    self.gpus[msg.sender].hourly_rate = new_rate

@public
def update_gpu_performance(new_performance: uint256):
    self.gpus[msg.sender].performance = new_performance

@public
@payable
def rent_gpu(gpu_owner: address, hours: uint256):
    gpu = self.gpus[gpu_owner]
    rent_price = gpu.hourly_rate * hours
    assert msg.value >= rent_price, "Insufficient funds for rental"
    
    self.rentals[msg.sender] = Rental({
        renter: msg.sender,
        gpu: gpu,
        start_time: block.timestamp,
        end_time: block.timestamp + hours * 3600,
        escrow: msg.value
    })

@public
def get_rental(renter: address) -> Rental:
    return self.rentals[renter]

@public
def release_escrow(renter: address):
    rental = self.rentals[renter]
    assert block.timestamp >= rental.end_time, "Rental period not yet over"
    
    send(rental.gpu.owner, rental.escrow)
    rental.escrow = 0