// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "./RealEstateToken.sol";
import "./interfaces/IZRSign.sol";

contract RealEstateMarketplace {
    RealEstateToken private _realEstateToken;
    IZRSign private _zrSign;

    constructor(address realEstateTokenAddress, address zrSignAddress) {
        _realEstateToken = RealEstateToken(realEstateTokenAddress);
        _zrSign = IZRSign(zrSignAddress);
    }

    function buyProperty(uint256 tokenId) external {
        address seller = _realEstateToken.ownerOf(tokenId);
        require(seller != address(0), "Property does not exist");

        // Here, you'd use zrSign to handle the transaction securely.
        // For demonstration purposes, we'll assume zrSign provides a signTransaction function.
        bytes memory transactionData = abi.encodeWithSignature(
            "transferFrom(address,address,uint256)",
            seller,
            msg.sender,
            tokenId
        );

        _zrSign.signTransaction(transactionData);

        // Transfer the property to the buyer.
        _realEstateToken.safeTransferFrom(seller, msg.sender, tokenId);
    }
}
