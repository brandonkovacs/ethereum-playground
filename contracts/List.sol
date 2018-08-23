pragma solidity ^0.4.0;
pragma experimental ABIEncoderV2;

contract List {
    mapping (address => string[]) _data;
    address _creator;

    constructor() public {
        _creator = msg.sender;
    }

    function add(string text) public {
        require(bytes(text).length > 0, "String must not be empty.");
        _data[msg.sender].push(text);
    }

    function getList() public constant returns (string[]) {
        return _data[msg.sender];
    }

    function getListSize() public constant returns (uint) {
        return _data[msg.sender].length;
    }

    function kill() public {
        if (msg.sender == _creator) {
            selfdestruct(_creator);
        }
    }
}
