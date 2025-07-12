// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract EmployeeStorage {
    // Custom error for too many shares
    error TooManyShares(uint newTotal);

    // State variables (packed for storage efficiency)
    uint16 private shares; // max 5000 for employees
    uint32 private salary; // max 1,000,000
    string public name;
    uint256 public idNumber;

    // Constructor sets initial values
    constructor() {
        shares = 1000;
        name = "Pat";
        salary = 50000;
        idNumber = 112358132134;
    }

    // View salary
    function viewSalary() public view returns (uint32) {
        return salary;
    }

    // View shares
    function viewShares() public view returns (uint16) {
        return shares;
    }

    // Grant shares
    function grantShares(uint _newShares) public {
        if (_newShares > 5000) {
            revert("Too many shares");
        }
        uint newTotal = shares + uint16(_newShares);
        if (newTotal > 5000) {
            revert TooManyShares(newTotal);
        }
        shares = uint16(newTotal);
    }

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

