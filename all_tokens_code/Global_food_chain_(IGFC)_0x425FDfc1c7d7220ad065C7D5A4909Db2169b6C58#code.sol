//token_name	Global_food_chain_(IGFC)
//token_url	https://etherscan.io//address/0x425FDfc1c7d7220ad065C7D5A4909Db2169b6C58#code
//spider_time	2018/07/08 11:29:04
//token_Transactions	7 txns
//token_price	

pragma solidity ^0.4.16;
contract Token{
    uint256 public totalSupply;

    function balanceOf(address _owner) public constant returns (uint256 balance);
    function transfer(address _to, uint256 _value) public returns (bool success);
    function transferFrom(address _from, address _to, uint256 _value) public returns   
    (bool success);
    
    function approve(address _spender, uint256 _value) public returns (bool success);
    
    function allowance(address _owner, address _spender) public constant returns 
    (uint256 remaining);

    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 
    _value);
}

contract IGFC is Token {
    mapping (address => uint256) balances;
    mapping (address => mapping (address => uint256)) allowed;
    
    string public name;                  
    uint8 public decimals;            
    string public symbol;           
    
    function IGFC(uint256 _initialAmount, string _tokenName, uint8 _decimalUnits, string _tokenSymbol) public {
        totalSupply = _initialAmount * 10 ** uint256(_decimalUnits);      
        balances[msg.sender] = totalSupply;
        
        name = _tokenName;                   
        decimals = _decimalUnits;          
        symbol = _tokenSymbol;
    }
    
    function transfer(address _to, uint256 _value) public returns (bool success) {
        require(balances[msg.sender] >= _value && balances[_to] + _value > balances[_to]);
        require(_to != 0x0);
        balances[msg.sender] -= _value;
        balances[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }


    function transferFrom(address _from, address _to, uint256 _value) public returns 
    (bool success) {
        require(balances[_from] >= _value && allowed[_from][msg.sender] >= _value);
        balances[_to] += _value;
        balances[_from] -= _value;
        allowed[_from][msg.sender] -= _value;
        emit Transfer(_from, _to, _value);
        return true;
    }
    function balanceOf(address _owner) public constant returns (uint256 balance) {
        return balances[_owner];
    }


    function approve(address _spender, uint256 _value) public returns (bool success)   
    { 
        allowed[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    function allowance(address _owner, address _spender) public constant returns (uint256 remaining) {
        return allowed[_owner][_spender];
    }

}