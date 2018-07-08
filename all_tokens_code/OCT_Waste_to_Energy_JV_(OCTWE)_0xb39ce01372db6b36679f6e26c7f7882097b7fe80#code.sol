//token_name	OCT_Waste_to_Energy_JV_(OCTWE)
//token_url	https://etherscan.io//address/0xb39ce01372db6b36679f6e26c7f7882097b7fe80#code
//spider_time	2018/07/08 12:04:19
//token_Transactions	2 txns
//token_price	

pragma solidity ^0.4.11;
contract OCTWasteToEnergyJV {
    
    uint public constant _totalSupply = 300000000000000000000000000;
    
    string public constant symbol = "OCTWE";
    string public constant name = "OCT Waste to Energy JV";
    uint8 public constant decimals = 18;
    
    mapping(address => uint256) balances;
    mapping(address => mapping(address => uint256)) allowed;
    
    function OCTWasteToEnergyJV() {
        balances[msg.sender] = _totalSupply;
    }
    
    function totalSupply() constant returns (uint256 totalSupply) {
        return _totalSupply;
    }

    function balanceOf(address _owner) constant returns (uint256 balance) {
        return balances[_owner]; 
    }
    
    function transfer (address _to, uint256 _value) returns (bool success) {
        require(	
            balances[msg.sender] >= _value
            && _value > 0 
        );
        balances[msg.sender] -= _value;
        balances[_to] += _value;
        Transfer(msg.sender, _to, _value);
        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) returns (bool success) {
        require(
            allowed[_from][msg.sender] >= _value
            && balances[_from] >= _value
            && _value > 0 
        );
        balances[_from] -= _value;
        balances[_to] += _value;
        allowed [_from][msg.sender] -= _value;
        Transfer (_from, _to, _value);
    return true;
    }

    function approve(address _spender, uint256 _value) returns (bool success) {
    allowed[msg.sender][_spender] = _value;
    Approval(msg.sender, _spender, _value);
    return true;
    }

    function allowance(address _owner, address _spender) constant returns (uint256 remaining) {
    return allowed[_owner][_spender];
    }

    event Transfer(address indexed _from, address indexed _to, uint256 _value); 
    event Approval(address indexed _owner, address indexed _spender, uint256 _value); 
}