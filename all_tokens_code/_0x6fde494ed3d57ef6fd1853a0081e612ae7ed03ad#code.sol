//token_name	
//token_url	https://etherscan.io//address/0x6fde494ed3d57ef6fd1853a0081e612ae7ed03ad#code
//spider_time	2018/07/08 11:07:04
//token_Transactions	1 txn
//token_price	

contract Ownable {
  address public owner;


  event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);


  /**
   * @dev The Ownable constructor sets the original `owner` of the contract to the sender
   * account.
   */
  function Ownable() public {
    owner = msg.sender;
  }

  /**
   * @dev Throws if called by any account other than the owner.
   */
  modifier onlyOwner() {
    require(msg.sender == owner);
    _;
  }

  /**
   * @dev Allows the current owner to transfer control of the contract to a newOwner.
   * @param newOwner The address to transfer ownership to.
   */
  function transferOwnership(address newOwner) public onlyOwner {
    require(newOwner != address(0));
    emit OwnershipTransferred(owner, newOwner);
    owner = newOwner;
  }

}

contract SKYFTokenInterface {
    function balanceOf(address _owner) public view returns (uint256 balance);
    function transfer(address _to, uint256 _value) public returns (bool);
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool);
}

contract SKYFReserveFund is Ownable{
    uint256 public constant startTime = 1534334400;
    uint256 public constant firstYearEnd = startTime + 365 days;
    
    SKYFTokenInterface public token;

    function setToken(address _token) public onlyOwner returns (bool) {
        require(_token != address(0));
        if (token == address(0)) {
            token = SKYFTokenInterface(_token);
            return true;
        }
        return false;
    }

    function transfer(address _to, uint256 _value) public onlyOwner returns (bool) {
        require(now > firstYearEnd);

        token.transfer(_to, _value);

    }
}