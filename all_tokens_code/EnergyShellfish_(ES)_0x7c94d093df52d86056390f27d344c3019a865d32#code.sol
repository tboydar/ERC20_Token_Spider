//token_name	EnergyShellfish_(ES)
//token_url	https://etherscan.io//address/0x7c94d093df52d86056390f27d344c3019a865d32#code
//spider_time	2018/07/08 12:21:35
//token_Transactions	152 txns
//token_price	

pragma solidity ^0.4.19;

contract BaseToken {
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 public totalSupply;

    mapping (address => uint256) public balanceOf;
    mapping (address => mapping (address => uint256)) public allowance;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    function _transfer(address _from, address _to, uint _value) internal {
        require(_to != 0x0);
        require(balanceOf[_from] >= _value);
        require(balanceOf[_to] + _value > balanceOf[_to]);
        uint previousBalances = balanceOf[_from] + balanceOf[_to];
        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;
        assert(balanceOf[_from] + balanceOf[_to] == previousBalances);
        Transfer(_from, _to, _value);
    }

    function transfer(address _to, uint256 _value) public returns (bool success) {
        _transfer(msg.sender, _to, _value);
        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        require(_value <= allowance[_from][msg.sender]);
        allowance[_from][msg.sender] -= _value;
        _transfer(_from, _to, _value);
        return true;
    }

    function approve(address _spender, uint256 _value) public returns (bool success) {
        allowance[msg.sender][_spender] = _value;
        Approval(msg.sender, _spender, _value);
        return true;
    }
}

contract CustomToken is BaseToken {
    function CustomToken() public {
        totalSupply = 1000000000000000000000000000;
        name = 'EnergyShellfish';
        symbol = 'ES';
        decimals = 18;
        balanceOf[0xe1f77b81a2383162cbbdd0dd93630f31a6672477] = totalSupply;
        Transfer(address(0), 0xe1f77b81a2383162cbbdd0dd93630f31a6672477, totalSupply);
    }
}