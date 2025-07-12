// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "forge-std/Test.sol";
import "../src/EmployeeStorage.sol";

contract EmployeeStorageTest is Test {
    EmployeeStorage emp;

    function setUp() public {
        emp = new EmployeeStorage();
    }

    function testInitialValues() public {
        assertEq(emp.name(), "Pat");
        assertEq(emp.idNumber(), 112358132134);
        assertEq(emp.viewSalary(), 50000);
        assertEq(emp.viewShares(), 1000);
    }

    function testGrantSharesSuccess() public {
        emp.grantShares(100);
        assertEq(emp.viewShares(), 1100);
    }

    function testGrantSharesTooManySharesStringRevert() public {
        vm.expectRevert(bytes("Too many shares"));
        emp.grantShares(5001);
    }

    function testGrantSharesTooManySharesCustomError() public {
        vm.expectRevert(abi.encodeWithSelector(EmployeeStorage.TooManyShares.selector, 5100));
        emp.grantShares(4100);
    }

    function testDebugResetShares() public {
        emp.grantShares(100);
        emp.debugResetShares();
        assertEq(emp.viewShares(), 1000);
    }

    function testCheckForPacking() public {
        // Just call to ensure it doesn't revert
        emp.checkForPacking(0);
    }
} 