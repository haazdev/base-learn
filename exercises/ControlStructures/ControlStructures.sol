// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract ControlStructures {
    // Custom error for after hours
    error AfterHours(uint time);

    // FizzBuzz function
    function fizzBuzz(uint _number) public pure returns (string memory) {
        if (_number % 15 == 0) {
            return "FizzBuzz";
        } else if (_number % 3 == 0) {
            return "Fizz";
        } else if (_number % 5 == 0) {
            return "Buzz";
        } else {
            return "Splat";
        }
    }

    // Do Not Disturb function
    function doNotDisturb(uint _time) public pure returns (string memory) {
        // Panic if time >= 2400
        if (_time >= 2400) {
            assert(false); // triggers a panic
        }
        // After hours: >2200 or <800
        if (_time > 2200 || _time < 800) {
            revert AfterHours(_time);
        }
        // At lunch: 1200-1259
        if (_time >= 1200 && _time <= 1259) {
            revert("At lunch!");
        }
        // Morning: 800-1199
        if (_time >= 800 && _time <= 1199) {
            return "Morning!";
        }
        // Afternoon: 1300-1799
        if (_time >= 1300 && _time <= 1799) {
            return "Afternoon!";
        }
        // Evening: 1800-2200
        if (_time >= 1800 && _time <= 2200) {
            return "Evening!";
        }
        // Fallback (should never hit)
        return "";
    }
}

