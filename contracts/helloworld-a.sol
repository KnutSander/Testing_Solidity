// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract helloworld {
    string greeting;

    function store(string memory message) public {
        greeting = message;
    }

    function get() public view returns (string memory) {
        return greeting;
    }
}
