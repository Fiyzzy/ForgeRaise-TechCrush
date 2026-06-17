// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./ForgeToken.sol";
import "./ForgeNFT.sol";

contract ForgeRaise {
    ForgeToken public forgeToken;
    ForgeNFT public forgeNFT;

    address public owner;
    uint256 public goal;
    uint256 public deadline;
    uint256 public totalRaised;

    mapping(address => uint256) public contributions;

    event Contributed(address indexed backer, uint256 amount);
    event Withdrawn(address indexed owner, uint256 amount);

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    constructor(uint256 _goal, uint256 _durationDays) {
        owner = msg.sender;
        goal = _goal;
        deadline = block.timestamp + (_durationDays * 1 days);
        forgeToken = new ForgeToken();
        forgeNFT = new ForgeNFT();
    }

    function contribute() external payable {
        require(block.timestamp < deadline, "Campaign ended");
        require(msg.value > 0, "Must send ETH");

        contributions[msg.sender] += msg.value;
        totalRaised += msg.value;

        // Mint 1000 FORGE per 1 ETH
        uint256 tokenAmount = (msg.value * 1000) / 1e18;
        forgeToken.mint(msg.sender, tokenAmount);

        emit Contributed(msg.sender, msg.value);
    }

    function withdraw() external onlyOwner {
        require(block.timestamp >= deadline, "Campaign not ended");
        require(totalRaised >= goal, "Goal not reached");

        uint256 amount = address(this).balance;
        payable(owner).transfer(amount);
        emit Withdrawn(owner, amount);
    }
}
