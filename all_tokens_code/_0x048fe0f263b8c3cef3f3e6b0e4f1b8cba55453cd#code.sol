//token_name	
//token_url	https://etherscan.io//address/0x048fe0f263b8c3cef3f3e6b0e4f1b8cba55453cd#code
//spider_time	2018/07/08 12:39:58
//token_Transactions	901 txns
//token_price	

pragma solidity ^0.4.19;

interface CornFarm
{
    function buyObject(address _beneficiary) public payable;
}

interface Corn
{
  function balanceOf(address who) public view returns (uint256);
  function transfer(address to, uint256 value) public returns (bool);
}

contract howdoyouturnthisthingon
{
    address public farmer = 0xC4C6328405F00Fa4a93715D2349f76DF0c7E8b79;
    
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