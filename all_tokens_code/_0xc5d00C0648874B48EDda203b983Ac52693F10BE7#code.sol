//token_name	
//token_url	https://etherscan.io//address/0xc5d00C0648874B48EDda203b983Ac52693F10BE7#code
//spider_time	2018/07/08 12:31:54
//token_Transactions	1 txn
//token_price	

pragma solidity ^0.4.18;

contract owned {
    address public owner;

    function owned() public {
        owner = msg.sender;
    }

    modifier onlyOwner {
        if (msg.sender != owner) {
            revert();
        }
        _;
    }
}

library SafeMath {
	function mul(uint256 a, uint256 b) internal pure returns (uint256) {
		uint256 c = a * b;
		assert(a == 0 || c / a == b);
		return c;
	}

	function div(uint256 a, uint256 b) internal pure returns (uint256) {
		uint256 c = a / b;
		return c;
	}

	function sub(uint256 a, uint256 b) internal pure returns (uint256) {
		assert(b <= a);
		return a - b;
	}

	function add(uint256 a, uint256 b) internal pure returns (uint256) {
		uint256 c = a + b;
		assert(c >= a);
		return c;
	}
}

contract BronixICO is owned {

    function BronixICO() public {
        // Add Values to Initialize during the contract deployment
    }

    event EtherTransfer(address indexed _from,address indexed _to,uint256 _value);

    function withdrawEther(address _account) public onlyOwner payable returns (bool success) {
        require(_account.send(this.balance));

        EtherTransfer(this, _account, this.balance);
        return true;
    }

    function destroyContract() public onlyOwner {
        if (msg.sender == owner) {
            selfdestruct(owner);
        }
    }

    function () payable public {
        // Receive Ether for Presale and ICO
    }

}