//token_name	
//token_url	https://etherscan.io//address/0x7f6e0d152df1a237450eeffa4f10623ba21a4df0#code
//spider_time	2018/07/08 11:16:52
//token_Transactions	3 txns
//token_price	

pragma solidity ^0.4.24;

contract Storage {

    bytes32[] public data;
    bool readOnly;
    function uploadData(bytes32[100] _data) public {
        require(readOnly != true);
        uint index = data.length;
        for(uint i = 0; i < _data.length; i++) {
            data.length++;
            data[index + i] = _data[i];
        }
    }
    function uploadFinish() {
        readOnly = true;
    }
    function getData() public view returns (bytes){
        bytes memory result = new bytes(data.length*0x20);
        for(uint i = 0; i < data.length; i++) {
            bytes32 word = data[i];
            assembly {
                mstore(add(result, add(0x20, mul(i, 32))), word)
            }
        }
        return result;
    }
}