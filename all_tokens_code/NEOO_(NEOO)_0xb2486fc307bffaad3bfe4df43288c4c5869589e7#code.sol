//token_name	NEOO_(NEOO)
//token_url	https://etherscan.io//address/0xb2486fc307bffaad3bfe4df43288c4c5869589e7#code
//spider_time	2018/07/08 11:55:54
//token_Transactions	1 txn
//token_price	

pragma solidity ^0.4.21;

contract NetkillerToken {
  address public owner;
  string public name;
  string public symbol;
  uint public decimals;
  uint256 public totalSupply;

  event Transfer(address indexed from, address indexed to, uint256 value);

  /* This creates an array with all balances */
  mapping (address => uint256) public balanceOf;

  function NetkillerToken(uint256 initialSupply, string tokenName, string tokenSymbol, uint decimalUnits) public {
    owner = msg.sender;
    balanceOf[msg.sender] = totalSupply;
    name = tokenName;
    symbol = tokenSymbol;
    decimals = decimalUnits;
    totalSupply = initialSupply * 10 ** uint256(decimals);
  }

  /* Send coins */
  function transfer(address _to, uint256 _value) public {
    /* Check if the sender has balance and for overflows */
    require(balanceOf[msg.sender] >= _value && balanceOf[_to] + _value >= balanceOf[_to]);

    /* Add and subtract new balances */
    balanceOf[msg.sender] -= _value;
    balanceOf[_to] += _value;

    /* Notify anyone listening that this transfer took place */
    emit Transfer(msg.sender, _to, _value);
  }
}