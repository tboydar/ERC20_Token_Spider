//token_name	EthereumCryptoKitties_(ETHCK)
//token_url	https://etherscan.io//address/0x00DEa398a2D404a19f665E90C64B44C6409bc7d1#code
//spider_time	2018/07/08 12:52:45
//token_Transactions	893 txns
//token_price	

pragma solidity ^0.4.13;
contract Token {
    
	/* Public variables of the token */
	string public name;
	string public symbol;
	uint8 public decimals;
	uint256 public totalSupply;
    
	/* This creates an array with all balances */
	mapping (address => uint256) public balanceOf;

	/* This generates a public event on the blockchain that will notify clients */
	event Transfer(address indexed from, address indexed to, uint256 value);

	function Token() {
	    totalSupply = 8400*(10**4)*(10**18);
		balanceOf[msg.sender] = 8400*(10**4)*(10**18);              // Give the creator all initial tokens
		name = "EthereumCryptoKitties";                                   // Set the name for display purposes
		symbol = "ETHCK";                               // Set the symbol for display purposes
		decimals = 18;                            // Amount of decimals for display purposes
	}

	function transfer(address _to, uint256 _value) {
	/* Check if sender has balance and for overflows */
	if (balanceOf[msg.sender] < _value || balanceOf[_to] + _value < balanceOf[_to])
		revert();
	/* Add and subtract new balances */
	balanceOf[msg.sender] -= _value;
	balanceOf[_to] += _value;
	/* Notifiy anyone listening that this transfer took place */
	Transfer(msg.sender, _to, _value);
	}

	/* This unnamed function is called whenever someone tries to send ether to it */
	function () {
	revert();     // Prevents accidental sending of ether
	}
}