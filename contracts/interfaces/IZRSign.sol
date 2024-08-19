// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import "../libraries/SignTypes.sol";

interface IZrSign {
    // Request a public key for a given wallet type ID
    // This function should be payable to allow sending Ether along with the request
    function zrKeyReq(SignTypes.ZrKeyReqParams calldata params) external payable;

    // Request a signature for a hash
    // The hash is associated with a specific wallet type and public key index
    // The function is payable to allow sending Ether along with the request
    function zrSignHash(SignTypes.ZrSignParams calldata params) external payable;

    // Request a signature for data
    // The data is associated with a specific wallet type and public key index
    // The function is payable to allow sending Ether along with the request
    function zrSignData(SignTypes.ZrSignParams calldata params) external payable;

    // Request a signature for a transaction
    // The transaction data is associated with a specific wallet type and public key index
    // If the broadcast flag is true, the transaction will be broadcasted after being signed
    // The function is payable to allow sending Ether along with the request
    function zrSignTx(SignTypes.ZrSignParams calldata params) external payable;

    // Check if a wallet type is supported by the contract
    function isWalletTypeSupported(bytes32 walletTypeId) external view returns (bool);

    // Check if a chain ID is supported for a given wallet type
    function isChainIdSupported(bytes32 walletTypeId, bytes32 chainId) external view returns (bool);

    // Returns the identifier that gets incremented for each signing process
    function getTraceId() external view returns (uint256);

    // Returns how the fee for the requests is calculated
    function getBaseFee() external view returns (uint256);

    // Returns the network fee of the underlying protocol
    function getNetworkFee() external view returns (uint256);

    // Returns all wallets of a particular type that belong to a certain owner
    function getZrKeys(bytes32 walletTypeId, address owner) external view returns (string[] memory);

    // Returns the wallet of a specific type and index that belongs to a certain owner
    function getZrKey(bytes32 walletTypeId, address owner, uint256 index) external view returns (string memory);
}