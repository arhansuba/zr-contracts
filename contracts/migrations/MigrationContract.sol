// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/**
 * @title MigrationContract
 * @dev Contract for managing migrations and upgrades in a contract system.
 */
contract MigrationContract {
    // Events
    event MigrationInitiated(address indexed from, address indexed to, uint256 timestamp);
    event MigrationCompleted(address indexed from, address indexed to, uint256 timestamp);

    // State variables
    address public admin;
    address public currentImplementation;
    address public pendingImplementation;
    bool public migrationInProgress;

    // Modifiers
    modifier onlyAdmin() {
        require(msg.sender == admin, "Not authorized: Only admin can perform this action");
        _;
    }

    modifier noMigrationInProgress() {
        require(!migrationInProgress, "Migration already in progress");
        _;
    }

    modifier migrationInProgressOnly() {
        require(migrationInProgress, "No migration in progress");
        _;
    }

    constructor(address _initialImplementation) {
        admin = msg.sender;
        currentImplementation = _initialImplementation;
        migrationInProgress = false;
    }

    /**
     * @notice Initiates a migration to a new implementation contract.
     * @param newImplementation Address of the new implementation contract.
     */
    function initiateMigration(address newImplementation) external onlyAdmin noMigrationInProgress {
        require(newImplementation != address(0), "Invalid address: New implementation address cannot be zero");
        require(newImplementation != currentImplementation, "Same address: New implementation is the same as the current one");

        pendingImplementation = newImplementation;
        migrationInProgress = true;

        emit MigrationInitiated(currentImplementation, pendingImplementation, block.timestamp);
    }

    /**
     * @notice Completes the migration to the new implementation contract.
     */
    function completeMigration() external onlyAdmin migrationInProgressOnly {
        require(pendingImplementation != address(0), "No pending implementation: Migration was not initiated");

        currentImplementation = pendingImplementation;
        pendingImplementation = address(0);
        migrationInProgress = false;

        emit MigrationCompleted(currentImplementation, pendingImplementation, block.timestamp);
    }

    /**
     * @notice Retrieves the current implementation address.
     * @return Address of the current implementation contract.
     */
    function getCurrentImplementation() external view returns (address) {
        return currentImplementation;
    }

    /**
     * @notice Retrieves the pending implementation address.
     * @return Address of the pending implementation contract.
     */
    function getPendingImplementation() external view returns (address) {
        return pendingImplementation;
    }

    /**
     * @notice Retrieves the status of migration progress.
     * @return Boolean indicating if a migration is in progress.
     */
    function isMigrationInProgress() external view returns (bool) {
        return migrationInProgress;
    }

    /**
     * @notice Allows the admin to change the admin address.
     * @param newAdmin Address of the new admin.
     */
    function changeAdmin(address newAdmin) external onlyAdmin {
        require(newAdmin != address(0), "Invalid address: New admin address cannot be zero");
        admin = newAdmin;
    }
}
