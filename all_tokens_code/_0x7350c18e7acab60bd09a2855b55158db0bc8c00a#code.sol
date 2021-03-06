//token_name	
//token_url	https://etherscan.io//address/0x7350c18e7acab60bd09a2855b55158db0bc8c00a#code
//spider_time	2018/07/08 11:51:41
//token_Transactions	1 txn
//token_price	

/*
 * Ownable
 *
 * Base contract with an owner.
 * Provides onlyOwner modifier, which prevents function from running if it is called by anyone other than the owner.
 */

contract Ownable {
    address public owner;

    function Ownable() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    function transferOwnership(address newOwner) onlyOwner {
        if (newOwner != address(0)) {
            owner = newOwner;
        }
    }
}


contract Whitelist is Ownable {
    mapping (address => uint128) whitelist;

    event Whitelisted(address who, uint128 nonce);

    function Whitelist() Ownable() {
      // This is here for our verification code only
    }

    function setWhitelisting(address who, uint128 nonce) internal {
        whitelist[who] = nonce;

        Whitelisted(who, nonce);
    }

    function whitelistUser(address who, uint128 nonce) external onlyOwner {
        setWhitelisting(who, nonce);
    }

    function whitelistMe(uint128 nonce, uint8 v, bytes32 r, bytes32 s) external {
        bytes32 hash = keccak256(msg.sender, nonce);
        require(ecrecover(hash, v, r, s) == owner);
        require(whitelist[msg.sender] == 0);

        setWhitelisting(msg.sender, nonce);
    }

    function isWhitelisted(address who) external view returns(bool) {
        return whitelist[who] > 0;
    }
}