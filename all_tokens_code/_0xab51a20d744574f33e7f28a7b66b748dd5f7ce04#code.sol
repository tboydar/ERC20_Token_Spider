//token_name	
//token_url	https://etherscan.io//address/0xab51a20d744574f33e7f28a7b66b748dd5f7ce04#code
//spider_time	2018/07/08 12:46:29
//token_Transactions	3 txns
//token_price	

pragma solidity ^0.4.19;

//Submit your eth to show how big your Eth penis is. The 
//biggest Eth dick for 2 days wins the balance and can claim
//prize restarting the game. The creator gets 3% and the
//winner gets the rest.
contract EthDickMeasuringGame {
    address public largestPenisOwner;
    address public owner;
    uint public largestPenis;
    uint public withdrawDate;

    function EthDickMeasuringGame() public{
        owner = msg.sender;
        largestPenisOwner = 0;
        largestPenis = 0;
    }

    function () public payable{
        require(largestPenis < msg.value);
        largestPenis = msg.value;
        withdrawDate = now + 2 days;
        largestPenisOwner = msg.sender;
    }

    function withdraw() public{
        require(now >= withdrawDate);

        //Reset game
        largestPenis = 0;

        //Judging penises isn't a fun job
        //taking my 3% from the total prize.
        owner.transfer(this.balance*3/100);
        
        //Congratulation on your giant penis
        largestPenisOwner.transfer(this.balance);
        largestPenisOwner = 0;
    }
}