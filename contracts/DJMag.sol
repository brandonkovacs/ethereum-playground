pragma solidity ^0.4.0;
contract DJMag {
    address _djmag;
    string[] _artists;

    mapping (address => string) _votesMap;
    mapping (string => uint) _voteCount;
    mapping (address => bool) _hasVotedMap;

    bool _votingActive;

    // Default constructor - sets _djmag to contract creator address and enables voting
    constructor() public {
        _djmag = msg.sender;
        _votingActive = true;
    }

    // Modifier to check if voting is active/allowed
    modifier VotingActive() {
        require(_votingActive == true,"DJ Mag Top 100 Voting has to be active.");
        _;
    }

    // Modifier to enforce single voting
    modifier firstTimeVoter() {
        require(_hasVotedMap[msg.sender] == false, "Can only vote once.");
        _;
    }

    // Modifier to only allow revealing winner after voting is over
    modifier canRevealWinner() {
        require(_votingActive == false, "Winner can only be revealed once voting has ended.");
        _;
    }

    // Modifier to ensure address belongs to contract owner
    modifier isContractOwner() {
        require(msg.sender == _djmag, "Must be contract owner.");
        _;
    }

    // Method to activate or deactivate voting - can only be called by contract owner
    function setVotingActive(bool votingAllowed) public isContractOwner {
        _votingActive = votingAllowed;
    }

    // Method to cast a vote - only if voting is allowed and its their first time
    function vote(string artist) public VotingActive firstTimeVoter {

        // Only proceed if they haven't already voted
        if (!hasVoted(msg.sender)) {
            _artists.push(artist);
            _voteCount[artist]++;
            _hasVotedMap[msg.sender] = true;
        }
    }

    // Method to check if person has already voted
    function hasVoted(address _address) public constant returns (bool) {
        return _hasVotedMap[_address];
    }

    // Method to return the winner - only after voting period has finished
    function revealWinner() canRevealWinner public constant returns (string) {
        var winner = "";
        uint winningVotes = 0;

        // Iterate through votes and return artist with the most
        for (uint i = 0; i < _artists.length; ++i) {
            if (_voteCount[ _artists[i] ] > winningVotes) {
                winningVotes = _voteCount[_artists[i]];
                winner = _artists[i];
            }
        }

        return winner;
    }

    // Method to tally the votes
    function getVotes(string artist) public constant returns (uint) {
        return _voteCount[artist];
    }

    // Method to return whether or not voting is active
    function isVotingActive() public constant returns (bool) {
        return _votingActive;
    }

    // Secure string comparison
    function compareStrings (string a, string b) private view returns (bool){
        return keccak256(a) == keccak256(b);
    }

    // Self destruct method
    function kill() public {
        if (msg.sender == _djmag) {
            selfdestruct(_djmag);
        }

    }
}