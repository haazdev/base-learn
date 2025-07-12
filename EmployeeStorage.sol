// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title EmployeeStorage (Base Learn – Storage Exercise)
/// @author  
/// @notice Implements the specification outlined in Exercise 3 of the Base Learn “Storage” section.
/// @dev  State variables are tightly packed for gas efficiency.
contract EmployeeStorage {
    /* ---------------------------------------------------------------------
                                   STORAGE
    --------------------------------------------------------------------- */
    // Packed into the same 32-byte slot (5 bytes total).
    // ‑ shares fits in uint16  (0 – 65 535)
    // ‑ salary fits in uint24  (0 – 16 777 215)
    uint16 private shares;   // employee share count (private)
    uint24 private salary;   // employee salary in dollars (private)

    // Dynamic bytes pointer occupies its own slot.
    string public name;      // employee name (public)

    // Full-width ID number (public)
    uint256 public idNumber;

    /* ---------------------------------------------------------------------
                                    ERRORS
    --------------------------------------------------------------------- */
    /// @notice Thrown when granting shares would exceed the 5 000-share limit.
    /// @param resultingShares The share balance that would result
    error TooManyShares(uint256 resultingShares);

    /* ---------------------------------------------------------------------
                                 CONSTRUCTOR
    --------------------------------------------------------------------- */
    /// @param _shares   Initial share balance (≤ 5 000 for non-director)
    /// @param _name     Employee name
    /// @param _salary   Salary (0 – 1 000 000 dollars)
    /// @param _idNumber Arbitrary employee ID number
    constructor(
        uint16 _shares,
        string memory _name,
        uint24 _salary,
        uint256 _idNumber
    ) {
        shares   = _shares;
        name     = _name;
        salary   = _salary;
        idNumber = _idNumber;
    }

    /* ---------------------------------------------------------------------
                                   GETTERS
    --------------------------------------------------------------------- */
    /// @return Employee salary in dollars
    function viewSalary() external view returns (uint24) {
        return salary;
    }

    /// @return Employee share count
    function viewShares() external view returns (uint16) {
        return shares;
    }

    /* ---------------------------------------------------------------------
                              SHARE MANAGEMENT
    --------------------------------------------------------------------- */
    /// @notice Increase the employee’s share allotment.
    /// @param _newShares Number of shares to add
    /// @dev Reverts if constraints in exercise spec are violated.
    function grantShares(uint256 _newShares) external {
        // Immediate guard: requested grant itself must not exceed 5 000
        if (_newShares > 5000) revert("Too many shares");

        uint256 newTotal = uint256(shares) + _newShares;
        if (newTotal > 5000) revert TooManyShares(newTotal);

        shares = uint16(newTotal); // safe cast: newTotal ≤ 5 000 ≤ 65 535
    }

    /* ---------------------------------------------------------------------
                       DIAGNOSTIC / TESTING UTILITIES (UNCHANGED)
    --------------------------------------------------------------------- */
    /**
     * Do not modify this function.  It is used to enable the unit test for this pin
     * to check whether or not you have configured your storage variables to make
     * use of packing.
     *
     * If you wish to cheat, simply modify this function to always return `0`
     * I'm not your boss ¯\\_(ツ)_/¯
     *
     * Fair warning though, if you do cheat, it will be on the blockchain having been
     * deployed by your wallet....FOREVER!
     */
    function checkForPacking(uint _slot) public view returns (uint r) {
        assembly {
            r := sload(_slot)
        }
    }

    /**
     * Warning: Anyone can use this function at any time!
     */
    function debugResetShares() public {
        shares = 1000;
    }
}