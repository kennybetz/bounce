# @version  ^0.2.0
# @title    bounceContractFactory
# @author   Kenny

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
  
## Currently set to original bounce contract on Harmony testnet

@external
@payable
def buildBouncer( _receiverAddress : address ):
  self.myBouncer = create_forwarder_to( self.bounceContract , value=msg.value )
  bounce( self.myBouncer ).bounceONE( msg.sender , _receiverAddress )
  log BuildBouncer( msg.sender , _receiverAddress , self.myBouncer )
  
## buildBouncer creates copy of original bounce contract and initializes using
## bounceONE function. Events emit data needed for followup App flow.
## create_forwarder_to "Deploys a small contract that duplicates the logic of 
## the contract at target, but has it’s own state since every call to target 
## is made using DELEGATECALL to target. To the end user, this should be indistinguishable
## from an independantly deployed contract with the same code as target."
## "https://vyper.readthedocs.io/en/stable/built-in-functions.html#chain-interaction"
