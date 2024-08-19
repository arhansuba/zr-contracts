// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./ZrWallet.sol";


/**
 * @title ZrWalletManager
 * @dev Contract to manage multiple ZrWallet instances and perform administrative tasks.
 */
contract ZrWalletManager {
    // Events
    event WalletCreated(address indexed walletAddress, address[] owners, uint256 requiredConfirmations);
    event WalletOwnershipTransferred(address indexed walletAddress, address indexed newOwner);

    // State variables
    mapping(address => address[]) public walletOwners;
    mapping(address => uint256) public walletRequiredConfirmations;
    address[] public deployedWallets;

    // Modifiers
        require(ZrWallet(walletAddress).isOwner(msg.sender), "Not authorized: Caller is not an owner)");
        require(payable(address(ZrWallet(walletAddress))).isOwner(msg.sender), "Not authorized: Caller is not an owner");
        _;
    }

    /**
     * @notice Create a new ZrWallet instance.
     * @param _owners Array of owner addresses.
     * @param _requiredConfirmations Number of confirmations required for transactions.
     * @return walletAddress Address of the newly created wallet.
     */
    function createWallet(address[] memory _owners, uint256 _requiredConfirmations) external returns (address walletAddress) {
        require(_owners.length > 0, "No owners provided");
        require(_requiredConfirmations > 0 && _requiredConfirmations <= _owners.length, "Invalid number of required confirmations");

        ZrWallet wallet = new ZrWallet(_owners, _requiredConfirmations);
        walletAddress = address(wallet);

        // Record wallet details
        walletOwners[walletAddress] = _owners;
        walletRequiredConfirmations[walletAddress] = _requiredConfirmations;
        deployedWallets.push(walletAddress);

        emit WalletCreated(walletAddress, _owners, _requiredConfirmations);
    }

    /**
     * @notice Transfer ownership of a ZrWallet instance.
     * @param walletAddress Address of the wallet.
     * @param newOwner Address of the new owner.
     */
    function transferWalletOwnership(address walletAddress, address newOwner) external onlyWalletOwner(walletAddress) {
        require(newOwner != address(0), "Invalid address: New owner cannot be zero address");

        // Update owner list
        address[] storage owners = walletOwners[walletAddress];
        for (uint i = 0; i < owners.length; i++) {
            if (owners[i] == msg.sender) {
                owners[i] = newOwner;
                emit WalletOwnershipTransferred(walletAddress, newOwner);
                break;
            }
        }
    }

    /**
     * @notice Get the list of deployed ZrWallet addresses.
     * @return Array of wallet addresses.
     */
    function getDeployedWallets() external view returns (address[] memory) {
        return deployedWallets;
    }

    /**
     * @notice Get wallet details.
     * @param walletAddress Address of the wallet.
     * @return owners Array of owner addresses.
     * @return requiredConfirmations Number of required confirmations for transactions.
     */
    function getWalletDetails(address walletAddress) external view returns (address[] memory owners, uint256 requiredConfirmations) {
        return (walletOwners[walletAddress], walletRequiredConfirmations[walletAddress]);
    }
}
