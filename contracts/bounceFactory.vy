# @version ^0.2.0
# @title bounceContractFactory

bounceContract  :  public(address)
myBouncer        :  public(address)

event BuildBouncer:
  myAddress        :  address
  myBounceAddress :  address

interface bounce:
  def bounceONE( _myAddress : address , _receiverAddress : address ): payable

@external
def __init__():
  self.bounceContract =  0x3194cBDC3dbcd3E11a07892e7bA5c3394048Cc87

@external
@payable
def buildBouncer( _receiverAddress : address ):
  self.myBouncer = create_forwarder_to( self.bounceContract , value=msg.value )
  bounce( self.myBouncer ).bounceONE( msg.sender , _receiverAddress )
  log BuildBouncer( msg.sender , self.myBouncer )
