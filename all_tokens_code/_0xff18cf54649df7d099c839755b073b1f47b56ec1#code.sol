//token_name	
//token_url	https://etherscan.io//address/0xff18cf54649df7d099c839755b073b1f47b56ec1#code
//spider_time	2018/07/08 12:53:36
//token_Transactions	28 txns
//token_price	

pragma solidity ^0.4.18;

/**
 * @title ERC20Basic
 * @dev Simpler version of ERC20 interface
 * @dev see https://github.com/ethereum/EIPs/issues/179
 */
contract ERC20Basic {
  uint256 public totalSupply;
  function balanceOf(address who) public constant returns (uint256);
  function transfer(address to, uint256 value) public returns (bool);
  event Transfer(address indexed from, address indexed to, uint256 value);
}

/**
 * @title ERC20 interface
 * @dev see https://github.com/ethereum/EIPs/issues/20
 */
contract ERC20 is ERC20Basic {
  function allowance(address owner, address spender) public constant returns (uint256);
  function transferFrom(address from, address to, uint256 value) public returns (bool);
  function approve(address spender, uint256 value) public returns (bool);
  event Approval(address indexed owner, address indexed spender, uint256 value);
}

/**
 * @title Ownable
 * @dev The Ownable contract has an owner address, and provides basic authorization control
 * functions, this simplifies the implementation of "user permissions".
 */
contract Ownable {
  address public owner;

  event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

  function Ownable() public {
    owner = msg.sender;
  }

  modifier onlyOwner() {
    require(msg.sender == owner);
    _;
  }

  function transferOwnership(address newOwner) public onlyOwner {
    require(newOwner != address(0));
    OwnershipTransferred(owner, newOwner);
    owner = newOwner;
  }
}

contract Bounty0x is Ownable {
    ERC20 public token;

    function Bounty0x(address _tokenAddress) public {
        token = ERC20(_tokenAddress);
    }

    function distributeToAddressesAndAmounts(address[] addresses, uint256[] amounts) external onlyOwner {
        require(addresses.length == amounts.length);
        for (uint i = 0; i < addresses.length; i++) {
            require(token.transfer(addresses[i], amounts[i]));
        }
    }
}