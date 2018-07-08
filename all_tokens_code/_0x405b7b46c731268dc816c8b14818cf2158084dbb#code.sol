//token_name	
//token_url	https://etherscan.io//address/0x405b7b46c731268dc816c8b14818cf2158084dbb#code
//spider_time	2018/07/08 12:40:02
//token_Transactions	1 txn
//token_price	

pragma solidity ^0.4.4;
contract Owned{
	address owner;
	function Owned() public{
		owner = msg.sender;
	}
	modifier onlyOwner{
		require(msg.sender == owner);
		_;
	}
}
contract SectorCoin is Owned{
	struct User{
		string username;
		uint balance;
	}
	string public TokenName;
    uint8 public decimals= 18;
    string public symbol;
    uint public totalSupply= 22000000000000000000000000;
    uint public reserve = 8000000000000000000000000;
    
    uint256 public sellPrice;
    uint256 public buyPrice;

	function SectorCoin(){
	    users[msg.sender].balance = totalSupply;
        TokenName = "SectorCoin";
        decimals = 18;
        symbol = "STC";
	}
	mapping (address => User) users;
	address[] public userAccounts;
	
	event userInfo(
		string username,
		uint balance
	);
	event Transfer(address indexed _from, address indexed _to, uint256 _value);
	/**
	function () {
        //if ether is sent to this address, send it back.
        throw;
    }
	**/
	function setUser(address _address,string _username,uint _balance) public {
		var user = users[_address];
		user.username = _username;
		user.balance = _balance;
		
		if(owner == _address){
		user.balance = totalSupply;    
		}
		userAccounts.push(_address)-1;
		userInfo(_username,_balance);
	}
	
	function getUsers() view public returns(address[]){
	return userAccounts;
	}
	
	function getUser(address _address) view public returns(string,uint){
		return (users[_address].username,users[_address].balance);
	}
	function countUsers() view public returns (uint){
	userAccounts.length;
	}
	function transfer(address _to, uint256 _value) onlyOwner returns (bool success) {
        require (_to != 0x0);
        require (users[owner].balance >= _value);
        if (users[owner].balance >= _value && _value > 0) {
            if(totalSupply <= reserve){
                users[owner].balance += totalSupply;
                return false;
            }
            
            users[owner].balance -= _value;
            users[_to].balance += _value;
            totalSupply -= _value;
            Transfer(owner, _to, _value);
            return true;
        } else { return false; }
    }
	function transferFrom(address _from,address _to, uint256 _value) returns (bool success){
	    if (users[_from].balance >= _value && _value > 0){
	        users[_from].balance -= _value;
	        users[_to].balance += _value;
	    }
	    return false;
	}
	function setPrices(uint256 newSellPrice, uint256 newBuyPrice) onlyOwner public {
        sellPrice = newSellPrice;
        buyPrice = newBuyPrice;
    }
    
    function buy() payable public {
        uint amount = msg.value / buyPrice; 
        transfer(this, amount);              
    }
    
    function sell(uint256 amount) public {
        require(this.balance >= amount * sellPrice);      // checks if the contract has enough ether to buy
        transferFrom(msg.sender, this, amount);              // makes the transfers
        msg.sender.transfer(amount * sellPrice);          // sends ether to the seller. It's important to do this last to avoid recursion attacks
    }
	
}