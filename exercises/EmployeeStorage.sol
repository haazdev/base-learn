// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract EmployeeStorage {
    // packed into the same 32-byte slot (2 + 3 bytes = 5 bytes)
    uint16 private shares;   // up to 5,000
    uint24 private salary;   // up to 1,000,000

    string public name;      // dynamic data pointer (own slot)
    uint256 public idNumber; // full-width ID (own slot)

    // constructor — initializes the four state variables
    constructor(
        uint16 _shares,
        string memory _name,
        uint24 _salary,
        uint256 _idNumber
    ) {
        shares = _shares;
        name = _name;
        salary = _salary;
        idNumber = _idNumber;
    }

    // Returns the employee’s salary
    function viewSalary() external view returns (uint24) {
        return salary;
    }

    // Returns the employee’s share count
    function viewShares() external view returns (uint16) {
        return shares;
    }

    // Custom error for exceeding share limit
    error TooManyShares(uint256 resultingShares);

    // Adds shares to the employee, enforcing limits per spec
    function grantShares(uint256 _newShares) external {
        // If the incoming grant itself exceeds 5000, revert with string
        if (_newShares > 5000) revert("Too many shares");

        uint256 newTotal = uint256(shares) + _newShares;

        // If resulting total would exceed 5000, revert with custom error
        if (newTotal > 5000) revert TooManyShares(newTotal);

        // Safe: newTotal <= 5000, fits in uint16
        shares = uint16(newTotal);
    }

    // ------------------------------------------------------------------
    // Diagnostic helper functions (do not modify)
    /**
    * Do not modify this function.  It is used to enable the unit test for this pin
    * to check whether or not you have configured your storage variables to make
    * use of packing.
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