//token_name	
//token_url	https://etherscan.io//address/0x119294d59973b6f91cd39270ae3ccb7f1a99c291#code
//spider_time	2018/07/08 11:56:50
//token_Transactions	4 txns
//token_price	

pragma solidity ^0.4.8;
    contract MyEtherTellerEntityDB  {
        
        //Author: Nidscom.io
        //Date: 23 March 2017
        //Version: MyEtherTellerEntityDB v1.0
        
        address public owner;
        

        //Entity struct, used to store the Buyer, Seller or Escrow Agent's info.
        //It is optional, Entities can choose not to register their info/name on the blockchain.


        struct Entity{
            string name;
            string info;      
        }


        
               
        mapping(address => Entity) public buyerList;
        mapping(address => Entity) public sellerList;
        mapping(address => Entity) public escrowList;

      
        //Run once the moment contract is created. Set contract creator
        function MyEtherTellerEntityDB() {
            owner = msg.sender;


        }



        function() payable
        {
            //LogFundsReceived(msg.sender, msg.value);
        }

        
        function registerBuyer(string _name, string _info)
        {
           
            buyerList[msg.sender].name = _name;
            buyerList[msg.sender].info = _info;

        }

    
       
        function registerSeller(string _name, string _info)
        {
            sellerList[msg.sender].name = _name;
            sellerList[msg.sender].info = _info;

        }

        function registerEscrow(string _name, string _info)
        {
            escrowList[msg.sender].name = _name;
            escrowList[msg.sender].info = _info;
            
        }

        function getBuyerFullInfo(address buyerAddress) constant returns (string, string)
        {
            return (buyerList[buyerAddress].name, buyerList[buyerAddress].info);
        }

        function getSellerFullInfo(address sellerAddress) constant returns (string, string)
        {
            return (sellerList[sellerAddress].name, sellerList[sellerAddress].info);
        }

        function getEscrowFullInfo(address escrowAddress) constant returns (string, string)
        {
            return (escrowList[escrowAddress].name, escrowList[escrowAddress].info);
        }
        
}