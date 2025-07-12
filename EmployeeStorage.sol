pragma solidity ^0.8.20;

/// @title Exercise 3 – EmployeeStorage contract for Base Learn
/// @notice Implements the specification from the “Storage” exercise, optimising for packed storage layout
contract EmployeeStorage {
    /* ---------------------------------------------------------------------
                                   STORAGE
    --------------------------------------------------------------------- */
    // NOTE: uint types are chosen to ensure these two variables share the same
    // 32-byte storage slot (packing optimisation).
    // ‑ shares fits in < 65 535, so uint16 (2 bytes)
    // ‑ salary fits in < 1 000 000, so uint24 (3 bytes)
    // 2 + 3 = 5 bytes → both variables occupy the first slot together.
    uint16 private shares;
    uint24 private salary;

    // Dynamic data pointers occupy their own slot; no packing benefit.
    string public name;

    // idNumber can be any uint256, so keep full 32-byte width
    uint256 public idNumber;

    /* ---------------------------------------------------------------------
                                  ERRORS
    --------------------------------------------------------------------- */
    /// @dev Thrown when granting shares would push total above 5 000
    /// @param resultingShares The share balance that would result
    error TooManyShares(uint256 resultingShares);

    /* ---------------------------------------------------------------------
                                CONSTRUCTOR
    --------------------------------------------------------------------- */
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

    /* ---------------------------------------------------------------------
                            VIEW / PURE FUNCTIONS
    --------------------------------------------------------------------- */
    /// @notice Returns the employee’s salary
    function viewSalary() external view returns (uint24) {
        return salary;
    }

    /// @notice Returns the employee’s share balance
    function viewShares() external view returns (uint16) {
        return shares;
    }

    /* ---------------------------------------------------------------------
                               SHARE LOGIC
    --------------------------------------------------------------------- */
    /// @notice Increase the employee’s shares
    /// @param _newShares Number of shares to grant
    function grantShares(uint16 _newShares) external {
        if (_newShares > 5000) revert("Too many shares");

        uint256 newTotal = uint256(shares) + uint256(_newShares);
        if (newTotal > 5000) revert TooManyShares(newTotal);

        shares = uint16(newTotal);
    }

    /* ---------------------------------------------------------------------
                    TEST-ONLY UTILITIES (DO NOT MODIFY)
    --------------------------------------------------------------------- */
    /**
     * Do not modify this function.  It is used to enable the unit test for this pin
     * to check whether or not you have configured your storage variables to make
     * use of packing.
     *
     * If you wish to cheat, simply modify this function to always return `0`
     * I'm not your boss ¯\_(ツ)_/¯
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