//token_name	
//token_url	https://etherscan.io//address/0x23483ed478b108e44f9610a86e715481ec607676#code
//spider_time	2018/07/08 11:57:15
//token_Transactions	2 txns
//token_price	

pragma solidity ^0.4.19;

contract owned {
    address public owner;
    address public candidate;

    function owned() payable public {
        owner = msg.sender;
    }
    
    modifier onlyOwner {
        require(owner == msg.sender);
        _;
    }
    function changeOwner(address _owner) onlyOwner public {
        candidate = _owner;
    }
    
    function confirmOwner() public {
        require(candidate == msg.sender);
        owner = candidate;
        delete candidate;
    }
}

contract CryptaurMigrations is owned
{
    address backend;
    modifier backendOrOwner {
        require(backend == msg.sender || msg.sender == owner);
        _;
    }

    mapping(bytes => address) addressByServices;
    mapping(address => bytes) servicesbyAddress;

    event AddService(uint dateTime, bytes serviceName, address serviceAddress);

    function CryptaurMigrations() public owned() { }
    
    function setBackend(address _backend) onlyOwner public {
        backend = _backend;
    }
    
    function setService(bytes serviceName, address serviceAddress) public backendOrOwner
    {
		addressByServices[serviceName] = serviceAddress;
		servicesbyAddress[serviceAddress] = serviceName;
		AddService(now, serviceName, serviceAddress);
    }
    
    function getServiceAddress(bytes serviceName) public view returns(address)
    {
		return addressByServices[serviceName];
    }

    function getServiceName(address serviceAddress) public view returns(bytes)
    {
		return servicesbyAddress[serviceAddress];
    }
}