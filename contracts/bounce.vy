# @version  ^0.2.0
# @title    bounce
# @author   Kenny

myAddress         :  public(address)
receiverAddress   :  public(address)

@external
def __init__():
  self.myAddress         =  0x1111111111111111111111111111111111111111
  self.receiverAddress   =  0x1111111111111111111111111111111111111111

## Setting myAddress and receiverAddress to verifiable burn accounts
## disables the selfdestruct function to be called on the original contract. 
## init function is not initialized on factory creation of new copy contract.

@external
@payable
def bounceONE( _myAddress : address , _receiverAddress : address ):
  assert self.myAddress  ==  ZERO_ADDRESS
  self.myAddress          =  _myAddress
  self.receiverAddress    =  _receiverAddress
  
## bounceONE function called during factory contract creation
## msg.value input in wallet is passed to new contract

@external
def grabONE():
  assert self.receiverAddress  ==  msg.sender
  selfdestruct(msg.sender)

@external
def bounceBackONE():
  assert self.myAddress  ==  msg.sender
  selfdestruct(msg.sender)
  
## only myAddress and receiverAddres can call selfdestruct removing
## the copy contract from the blockchain and sending the balance of
## the contract to the msg.sender
