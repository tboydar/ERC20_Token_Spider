//token_name	
//token_url	https://etherscan.io//address/0xed4ba2958a08511b615b6c92015a56c2ca05ba07#code
//spider_time	2018/07/08 11:13:16
//token_Transactions	1 txn
//token_price	

pragma solidity ^0.4.23;

interface token { function transfer(address receiver, uint amount);
}
contract WICCrowdsale {
    address public beneficiary; 
    uint public fundingGoal;
    uint public amountRaised; 
    uint public deadline; 

    uint public price;
    token public tokenReward; 
    mapping(address => uint256) public balanceOf;
    bool fundingGoalReached = false; 
    bool crowdsaleClosed = false; 

    event GoalReached(address recipient, uint totalAmountRaised);
    event FundTransfer(address backer, uint amount, bool isContribution);

    function WICCrowdsale(
        address ifSuccessfulSendTo,
        uint fundingGoalInEthers,
        uint durationInMinutes,
        uint etherCostOfEachToken,
        address addressOfTokenUsedAsReward
    ) {
        beneficiary = ifSuccessfulSendTo;
        fundingGoal = fundingGoalInEthers * 1 ether;
        deadline = now + durationInMinutes * 1 minutes;
        price = etherCostOfEachToken * 1 ether;
        tokenReward = token(addressOfTokenUsedAsReward);
    }

    function () payable {
       require(!crowdsaleClosed);
       uint amount = msg.value;
       balanceOf[msg.sender] += amount;
       amountRaised += amount;
       tokenReward.transfer(msg.sender, amount / price);  
       beneficiary.send(amountRaised);
       amountRaised = 0;
       FundTransfer(msg.sender, amount, true);
}

    modifier afterDeadline() {
          if (now >= deadline) _;
          }

    function checkGoalReached() afterDeadline {
        if (amountRaised >= fundingGoal){
            fundingGoalReached = true;
            GoalReached(beneficiary, amountRaised);
        }
        crowdsaleClosed = true;
    }

    function safeWithdrawal() afterDeadline {
        if (!fundingGoalReached) {
            uint amount = balanceOf[msg.sender];
            balanceOf[msg.sender] = 0;
            if (amount > 0) {
                if (msg.sender.send(amount)) {
                    FundTransfer(msg.sender, amount, false);
            }
            else {
                balanceOf[msg.sender] = amount;
                }
            }
        }
        if (fundingGoalReached && beneficiary == msg.sender) {
            if (beneficiary.send(amountRaised)) {
                FundTransfer(beneficiary, amountRaised, false);
            }
            else {
                fundingGoalReached = false;
            }
        }
    }
}