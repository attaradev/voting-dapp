// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract Candidate {
    // Track Candidate Name
    string public name;
    // Track Candidate Vote Count
    uint public voteCount;

    constructor(string memory _name) {
        name = _name;
    }

    // Increment Vote Count
    function incrementVoteCount() public {
        voteCount += 1;
    }
}
