# @version ^0.2.0
# @title bouncerContractFactory

bouncerContract  :  public(address)
myBouncer        :  public(address)

event BuildBouncer:
  myAddress        :  address
  myBouncerAddress :  address

interface bouncer:
  def sendONE( _myAddress : address , _receiverAddress : address ): payable

@external
def __init__():
  self.bouncerContract =  0x3194cBDC3dbcd3E11a07892e7bA5c3394048Cc87

@external
@payable
def buildBouncer( _receiverAddress : address ):
  self.myBouncer = create_forwarder_to( self.bouncerContract , value=msg.value )
  bouncer( self.myBouncer ).sendONE( msg.sender , _receiverAddress )
  log BuildBouncer( msg.sender , self.myBouncer )
