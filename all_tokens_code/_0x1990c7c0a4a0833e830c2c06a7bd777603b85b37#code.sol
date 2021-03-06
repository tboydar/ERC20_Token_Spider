//token_name	
//token_url	https://etherscan.io//address/0x1990c7c0a4a0833e830c2c06a7bd777603b85b37#code
//spider_time	2018/07/08 11:46:43
//token_Transactions	2 txns
//token_price	

pragma solidity ^0.4.19;

contract ERC20Basic {
  function totalSupply() public view returns (uint256);
  function balanceOf(address who) public view returns (uint256);
  function transfer(address to, uint256 value) public returns (bool);
  event Transfer(address indexed from, address indexed to, uint256 value);
}

contract ERC20 is ERC20Basic 
{

  function allowance(address owner, address spender) public view returns (uint256);
  function transferFrom(address from, address to, uint256 value) public returns (bool);
  function approve(address spender, uint256 value) public returns (bool);
  event Approval(address indexed owner, address indexed spender, uint256 value);
  
}

contract Airdroplet
{

    ERC20 public token;

    function airdropExecute(address source, address[] recipents, uint256 amount) public
    {

        uint x = 0;
        token = ERC20(source);

        while(x < recipents.length)
        {

          token.transferFrom(msg.sender, recipents[x], amount);
          x++;

        }

    }


}