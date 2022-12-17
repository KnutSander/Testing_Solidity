// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract helloworld {
    mapping(address => uint) balance;

    // deposit an amount into the contract
    function deposit() public payable {
        balance[msg.sender] += msg.value;
    }

    // get balance of a given account
    function getBalance(address memory account) public view returns(uint) {
        return balance[account];
    }

    // withdraw requested amount from the account balance
    function withdraw(uint256 memory amount) public {
        require(amount <= balance[msg.sender], "not enough funds available");
        address payable receiver = payable(msg.sender);
        balance[receiver] -= amount;
        receiver.transfer(amount);
    }
}
