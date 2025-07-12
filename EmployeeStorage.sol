// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract EmployeeStorage {
    // packed into the same 32-byte slot (2 + 3 bytes = 5 bytes)
    uint16 private shares;   // up to 5,000
    uint24 private salary;   // up to 1,000,000

    string public name;      // dynamic data pointer (own slot)
    uint256 public idNumber; // full-width ID (own slot)
}