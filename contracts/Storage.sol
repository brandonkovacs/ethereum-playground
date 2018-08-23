pragma solidity ^0.4.0;

contract Storage {
    string _data;
    address _creator;

    constructor() public {
        _creator = msg.sender;
    }

    function setData(string text) public {
        _data = text;
    }

    function getData() public constant returns (string) {
        return _data;
    }

    function kill() public {
        if (msg.sender == _creator) {
            selfdestruct(_creator);
        }
    }
}
