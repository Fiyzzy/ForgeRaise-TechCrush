// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract ForgeNFT is ERC721, Ownable {
    uint256 private _tokenIdCounter;

    constructor() ERC721("ForgeNFT", "FNFT") Ownable(msg.sender) {}

    function mint(address _to) external onlyOwner returns (uint256) {
        uint256 tokenId = _tokenIdCounter;
        _tokenIdCounter++;
        _safeMint(_to, tokenId);
        return tokenId;
    }
}
