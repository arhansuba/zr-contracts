// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract RealEstateToken is ERC721, Ownable {
    uint256 private _tokenIdCounter;

    constructor() ERC721("RealEstateToken", "RET") {}

    function mintProperty(address to) external onlyOwner {
        uint256 tokenId = _tokenIdCounter;
        _tokenIdCounter++;
        _mint(to, tokenId);
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return "https://api.realestate.example.com/metadata/";
    }
}
