//token_name	
//token_url	https://etherscan.io//address/0x99d804f479df333ed4d2287af2d4da3eda1b3cd1#code
//spider_time	2018/07/08 11:22:33
//token_Transactions	4 txns
//token_price	

pragma solidity ^0.4.17;

/**
 * @title EthealSplit
 * @dev Split ether evenly on the fly.
 * @author thesved, viktor.tabori at etheal.com
 */
contract EthealSplit {
    /// @dev Split evenly among addresses, no safemath is needed for divison
    function split(address[] _to) public payable {
        uint256 _val = msg.value / _to.length;
        for (uint256 i=0; i < _to.length; i++) {
            _to[i].send(_val);
        }

        if (address(this).balance > 0) {
            msg.sender.transfer(address(this).balance);
        }
    }
}