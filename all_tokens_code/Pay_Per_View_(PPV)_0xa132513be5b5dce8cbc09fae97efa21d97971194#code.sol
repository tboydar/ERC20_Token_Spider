//token_name	Pay_Per_View_(PPV)
//token_url	https://etherscan.io//address/0xa132513be5b5dce8cbc09fae97efa21d97971194#code
//spider_time	2018/07/08 11:17:51
//token_Transactions	4 txns
//token_price	

pragma solidity ^0.4.18;

contract PayPerView {
    /* Public variables of the Pay Per View */
    string public standard = 'PayPerView 1.0';
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 public initialSupply;
    uint256 public totalSupply;

    /* This creates an array with all balances */
    mapping (address => uint256) public balanceOf;
    mapping (address => mapping (address => uint256)) public allowance;

  
    /* Initializes contract with initial supply tokens to the creator of the contract */
    function PayPerView () public {

         initialSupply = 120000000000000000;
         name ="Pay Per View";
         decimals = 8;
         symbol = "PPV";
        
        balanceOf[msg.sender] = initialSupply;              // Give the creator all initial tokens
        totalSupply = initialSupply;                        // Update total supply
                                   
    }

    /* Send coins */
    function transfer(address _to, uint256 _value) public {
        if (balanceOf[msg.sender] < _value) revert();           // Check if the sender has revert()
        if (balanceOf[_to] + _value < balanceOf[_to]) revert(); // Check for overflows
        balanceOf[msg.sender] -= _value;                     // Subtract from the sender
        balanceOf[_to] += _value;                            // Add the same to the recipient
    }


    /* This unnamed function is called whenever someone tries to send ether to it */
    function () public {
        revert();     // Prevents accidental sending of ether
    }
}