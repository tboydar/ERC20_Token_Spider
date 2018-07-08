//token_name	Hipster_(HIP)
//token_url	https://etherscan.io//address/0x78d34185127bda2fce0e8b1ecba5a7aeea166802#code
//spider_time	2018/07/08 12:37:03
//token_Transactions	4 txns
//token_price	

pragma solidity ^0.4.18;

contract HipsterToken {

    string public name = "Hipster";      //  token name
    string public symbol = "HIP";           //  token symbol
    uint256 public decimals = 6;            //  token digit

    mapping (address => uint256) public balanceOf;
    mapping (address => mapping (address => uint256)) public allowance;

    uint256 public totalSupply = 65000000000000;
    address owner = 0x0;

    modifier validAddress {
        assert(0x0 != msg.sender);
        _;
    }

    function HipsterToken() {
        owner = msg.sender;
        balanceOf[owner] = totalSupply;
        Transfer(0x0, owner, totalSupply);
    }

    function transfer(address _to, uint256 _value) validAddress returns (bool success) {
        require(balanceOf[msg.sender] >= _value);
        require(balanceOf[_to] + _value >= balanceOf[_to]);
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
        Transfer(msg.sender, _to, _value);
        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) validAddress returns (bool success) {
        require(balanceOf[_from] >= _value);
        require(balanceOf[_to] + _value >= balanceOf[_to]);
        require(allowance[_from][msg.sender] >= _value);
        balanceOf[_to] += _value;
        balanceOf[_from] -= _value;
        allowance[_from][msg.sender] -= _value;
        Transfer(_from, _to, _value);
        return true;
    }

    function approve(address _spender, uint256 _value) validAddress returns (bool success) {
        require(_value == 0 || allowance[msg.sender][_spender] == 0);
        allowance[msg.sender][_spender] = _value;
        Approval(msg.sender, _spender, _value);
        return true;
    }

    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
}