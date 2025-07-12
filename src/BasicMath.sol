// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BasicMath {
    // Adder: Returns (sum, error)
    function adder(uint256 _a, uint256 _b) public pure returns (uint256 sum, bool error) {
        unchecked {
            sum = _a + _b;
            // Overflow occurs if sum < either operand
            if (sum < _a || sum < _b) {
                return (0, true);
            }
            return (sum, false);
        }
    }

    // Subtractor: Returns (difference, error)
    function subtractor(uint256 _a, uint256 _b) public pure returns (uint256 difference, bool error) {
        if (_a >= _b) {
            return (_a - _b, false);
        } else {
            return (0, true);
        }
    }
} 