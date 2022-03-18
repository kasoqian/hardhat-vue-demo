//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.5;

import "hardhat/console.sol";

contract Counter {
    uint256 counts;

    constructor() {
        counts = 0;
    }

    function getcounter() public view returns (uint256) {
        return counts;
    }

    function addcounter() public {
        counts++;
    }
}
