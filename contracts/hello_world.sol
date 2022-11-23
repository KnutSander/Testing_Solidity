// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract helloworld {
    
    // string[] greetings;

    // function store ( string memory message ) public {
    //     greetings.push(message);
    // }

    // function get ( uint pos ) public view returns ( string memory ) {
    //     if (pos >= greetings.length) {
    //         return "ERROR: Position larger than array length";
    //     } else {
    //         return greetings[pos];
    //     }
    // }

    // function reset () public {
    //     delete greetings;
    // }

    // Mao sender address to integers
    mapping(address => uint) balances;

    // payble keyword in function allows contract to recieve ETH, function can recieve ether
    function giveETH() external payable {
        // increase the senders balance with the recieved value
        balances[msg.sender] += msg.value;
    }

    // payable keyword used with address for inout variable tells compiler it can send money to the address
    function getETH(address payable recipient, uint amount) external returns(string memory) {
        //recipient.transfer(1 ether);
        // transfer 1 ether to the smart contract recipient, person or contract that called the function
        if(balances[msg.sender] >= amount){
            balances[msg.sender] -= amount;
            recipient.transfer(amount);
            return "Transaction succesful!";
        } else {
            return "Insufficient funds, please deposit more ETH!";
        }
    }

    function balance() external view returns(uint) {
        // Returns total value of contract
        //return address(this).balance;
        // Retuns the balance the given user has in the contract
        return balances[msg.sender];
    }
}