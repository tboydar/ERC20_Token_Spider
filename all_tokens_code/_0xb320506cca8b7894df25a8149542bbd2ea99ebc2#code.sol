//token_name	
//token_url	https://etherscan.io//address/0xb320506cca8b7894df25a8149542bbd2ea99ebc2#code
//spider_time	2018/07/08 12:21:33
//token_Transactions	24 txns
//token_price	

pragma solidity ^0.4.21;
contract RegistroBlockchain {

    struct Registro {
        bool existe;
        uint block_number;
    }

    mapping(bytes32 => Registro) public registros;
    address public admin;

    function RegistroBlockchain() public {
        admin = msg.sender;
    }
    
    function TrocarAdmin(address _admin) public {
        require(msg.sender == admin);
        admin = _admin;
    }

    function GuardaRegistro(bytes32 hash) public {
        require(msg.sender == admin);
        require(!registros[hash].existe);
        registros[hash].existe = true;
        registros[hash].block_number = block.number;
    }

    function ConsultaRegistro(bytes32 hash) public constant returns (uint) {
        require(registros[hash].existe);
        return (registros[hash].block_number);
    }
}