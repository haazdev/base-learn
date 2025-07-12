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
}