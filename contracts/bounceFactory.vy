# @version ^0.2.0
# @title bounceContractFactory

bounceContract  :  public(address)
myBouncer       :  public(address)

event BuildBouncer:
  myAddress        :  address
  receiverAddress  :  address
  myBounceAddress  :  address

interface bounce:
  def bounceONE( _myAddress : address , _receiverAddress : address ): payable

@external
def __init__():
  self.bounceContract  =  0xA94bFECf90390E574C81166D52f10C224d2904A9

@external
@payable
def buildBouncer( _receiverAddress : address ):
  self.myBouncer = create_forwarder_to( self.bounceContract , value=msg.value )
  bounce( self.myBouncer ).bounceONE( msg.sender , _receiverAddress )
  log BuildBouncer( msg.sender , _receiverAddress , self.myBouncer )
