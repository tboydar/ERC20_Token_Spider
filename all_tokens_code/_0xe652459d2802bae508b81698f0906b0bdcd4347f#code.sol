//token_name	
//token_url	https://etherscan.io//address/0xe652459d2802bae508b81698f0906b0bdcd4347f#code
//spider_time	2018/07/08 12:35:39
//token_Transactions	4 txns
//token_price	

pragma solidity ^0.4.19;

contract Treethereum {  
    mapping (address => address) inviter;
    
    function bytesToAddr (bytes b) constant returns (address)  {
        uint result = 0;
        for (uint i = b.length-1; i+1 > 0; i--) {
            uint c = uint(b[i]);
            uint to_inc = c * ( 16 ** ((b.length - i-1) * 2));
            result += to_inc;
        }
        return address(result);
    }
    
    function withdraw(uint amount) {
        if (this.balance >= amount) {
            msg.sender.transfer(amount);
        }
    }
    
    function addrecruit(address _recaddress, address _invaddress) private {
        if (inviter[_recaddress] != 0x0) {
                revert();
            }
        inviter[_recaddress] = _invaddress;
    }

    function () external payable { // Fallback Function
        address recaddress = msg.sender;
        invaddress = bytesToAddr(msg.data);
        if (invaddress == 0x0 || invaddress == recaddress) {
            address invaddress = 0x93D43eeFcFbE8F9e479E172ee5d92DdDd2600E3b;
        }
        addrecruit(recaddress, invaddress);
        uint i=0;
        uint amount = msg.value;
        if (amount < 0.2 ether) {
            msg.sender.transfer(msg.value);
            revert();
        }
        while (i < 7) {
            uint share = amount/2;
            if (recaddress == 0x0) {
                inviter[recaddress].transfer(share);
                recaddress = 0x93D43eeFcFbE8F9e479E172ee5d92DdDd2600E3b;
            }
            inviter[recaddress].transfer(share);
            recaddress = inviter[recaddress];
            amount -= share;
            i++;
        }
        inviter[recaddress].transfer(share);
    }
}