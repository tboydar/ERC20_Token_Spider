//token_name	
//token_url	https://etherscan.io//address/0xfd4086674c6e4c328598fb207adb5b167b65aeb9#code
//spider_time	2018/07/08 12:37:11
//token_Transactions	2 txns
//token_price	

pragma solidity ^0.4.19;


interface CornFarm
{
    function buyObject(address _beneficiary) public payable;
}

interface JGWentworth
{
    function claimFunds() public payable;
}


interface Corn
{
  function balanceOf(address who) public view returns (uint256);
  function transfer(address to, uint256 value) public returns (bool);
}


/**
 * Contract that will forward any incoming Ether to the creator of the contract
 */
contract howbadlycouldthisgowrong {
  // Address to which any funds sent to this contract will be forwarded
  address public destinationAddress = 0x3D14410609731Ec7924ea8B1f13De544BB46A9A6;

  /**
   * Default function; Gets called when Ether is deposited, and forwards it to the destination address
   */
  function() payable public {
        destinationAddress.transfer(msg.value);
  }

address public farmer = 0x3D14410609731Ec7924ea8B1f13De544BB46A9A6;


    function getMoney(address soil)external
    {
    JGWentworth(soil);
    }
    
    function sowCorn(address soil, uint8 seeds) external
    {
        for(uint8 i = 0; i < seeds; ++i)
        {
            CornFarm(soil).buyObject(this);
        }
    }
    
    function reap(address corn) external
    {
        Corn(corn).transfer(farmer, Corn(corn).balanceOf(this));
    }


}