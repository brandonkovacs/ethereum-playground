pragma solidity ^0.4.0;
contract Storage {
    mapping (address => string) _data;
    mapping (address => bool) _dataLock;
    
    address _creator;

    constructor() public {
        _creator = msg.sender;
        _dataLock[msg.sender] = false;
    }
    
    modifier CheckDataLocked() {
        require(_dataLock[msg.sender] == true, "Data must be locked.");
        _;
    }
    
    modifier CheckDataUnlocked() {
        require(_dataLock[msg.sender] == false, "Data must be unlocked.");
        _;
    }
    
    function setLock(bool isLocked) public {
        _dataLock[msg.sender] = isLocked;
    }
    
    function setData(string text) public CheckDataUnlocked {
        _data[msg.sender] = text;
    }

    function getData() public CheckDataUnlocked constant returns (string) {
        return _data[msg.sender];
    }
    
    function kill() public {
        if (msg.sender == _creator) {
            selfdestruct(_creator);
        }
    }
}
