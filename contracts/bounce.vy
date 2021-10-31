# @version 0.2.0
# @title bounce
# @author Kenny

myAddress         :  public(address)
receiverAddress   :  public(address)

@external
def __init__():
  self.myAddress         =  0x1111111111111111111111111111111111111111
  self.receiverAddress   =  0x1111111111111111111111111111111111111111

@external
@payable
def bounceONE( _myAddress : address , _receiverAddress : address ):
  assert self.myAddress  ==  ZERO_ADDRESS
  self.myAddress          =  _myAddress
  self.receiverAddress    =  _receiverAddress

@external
def grabONE():
  assert self.receiverAddress  ==  msg.sender
  selfdestruct(msg.sender)

@external
def bounceBackONE():
  assert self.myAddress  ==  msg.sender
  selfdestruct(msg.sender)
