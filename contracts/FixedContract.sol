// SPDX - License - Identifier : GPL -3.0

pragma solidity >=0.7.0 <0.9.0;

contract FContract {
    mapping (address => uint) public balances;


    function deposit() public payable {
        require (msg.value >= 1 ether, "Desposit must be no less than 1 Ether");
        balances[msg.sender] += msg.value;
    }

    function withdraw() public payable {
        bool lock;
        //check user's balance

        lock = true;
        require(!lock, "LOCKED");
        require(balances[msg.sender] >= 1 ether,"Balance needs to be at least 1 Ether");
        uint256 bal = balances[msg.sender];

        //SOLUTION 2
        //update balance before sending the value means that the function when reversibly called will be at 0
        //balances[msg.sender] = 0;



        //withdraw user balance 
        (bool sent,) = msg.sender.call{value: bal}("");
        require(sent, "Failed to withdraw");

        balances[msg.sender] = 0;

        lock = false;
    }

    //function to display balance
    function balance() public view returns (uint256){
        return address(this).balance;
    }

}
