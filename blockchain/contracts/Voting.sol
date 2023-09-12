// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "./Candidate.sol";

contract Voting {
    // Track Voter Registration
    mapping(address => bool) public voters;
    // Track Voters Voted
    mapping(address => bool) public hasVoted;
    // Track Candidates
    Candidate[] public candidateList;
    // Track Votes Tally
    uint public totalVotes;
    // Contract Owner
    address public owner;
    address public ec;

    constructor() {
        owner = msg.sender;
    }

    //modifier to check if is ec
    modifier isEC() {
        require(ec == msg.sender, "Not Electoral commissioner!");
        _;
    }

    //modifier to check if is owner
    modifier isOwner() {
        require(owner == msg.sender, "Not owner!");
        _;
    }

    //register EC
    function registerEC(address ecAddress) public isOwner {
        // Check If Sender is Owner
        // Register
        ec = ecAddress;
    }

    // Register Voter
    function registerVoter(address voterAddress) public isEC {
        // Register
        voters[voterAddress] = true;
    }

    // Add Candidate
    function addCandidate(string memory _name) public isEC {
        // Add Candidate
        Candidate newCandidate = new Candidate(_name);
        candidateList.push(newCandidate);
    }

    // Vote
    function vote(uint256 _candidateIndex) public {
        // Check if voter is registered
        require(voters[msg.sender], "Voter is not registered!");
        // Check if voter has not voted
        require(!hasVoted[msg.sender], "Voter has already voted!");
        // Check if candidate is valid
        require(_candidateIndex < candidateList.length, "Candidate not valid!");
        // Increase total votes
        totalVotes += 1;
        // Increase candidate vote
        Candidate(address(candidateList[_candidateIndex])).incrementVoteCount();
    }
}
