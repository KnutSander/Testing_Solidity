// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract helloworld {
    string[] messages = new string[](0); // initialize dynamic array

    function store(string memory message) public {
        messages.push(message);
    }

    function get(uint256 memory index) public view returns (string memory) {
        require(index < messages.length); // check that the index exists
        return messages[index];
    }

    function reset() public {
        messages = new string[](0); // reset the array
    }
}
