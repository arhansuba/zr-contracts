// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/**
 * @title IWalletManager
 * @dev Interface for managing wallets in a decentralized system.
 */
interface IWalletManager {
    
    /**
     * @notice Emitted when a new wallet is created.
     * @param walletAddress Address of the newly created wallet.
     * @param owner Address of the wallet owner.
     */
    event WalletCreated(address indexed walletAddress, address indexed owner);

    /**
     * @notice Emitted when a wallet is updated.
     * @param walletAddress Address of the updated wallet.
     * @param newOwner Address of the new owner.
     */
    event WalletUpdated(address indexed walletAddress, address indexed newOwner);

    /**
     * @notice Creates a new wallet and assigns it to the specified owner.
     * @param owner Address of the wallet owner.
     * @return walletAddress Address of the newly created wallet.
     */
    function createWallet(address owner) external returns (address walletAddress);

    /**
     * @notice Updates the ownership of an existing wallet.
     * @param walletAddress Address of the wallet to be updated.
     * @param newOwner Address of the new owner.
     */
    function updateWalletOwnership(address walletAddress, address newOwner) external;

    /**
     * @notice Retrieves the owner of a specific wallet.
     * @param walletAddress Address of the wallet.
     * @return owner Address of the wallet owner.
     */
    function getWalletOwner(address walletAddress) external view returns (address owner);

    /**
     * @notice Checks if an address is a valid wallet.
     * @param walletAddress Address to be checked.
     * @return isValid True if the address is a valid wallet, false otherwise.
     */
    function isValidWallet(address walletAddress) external view returns (bool isValid);
}

