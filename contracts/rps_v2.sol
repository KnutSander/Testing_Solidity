// SPDX-License-Identifier: GPL-3.0
// Slightly more advanced rock-paper-scissors in Solidity

pragma solidity >=0.7.0 <0.9.0;

contract RPS_v2 {

    // Enums for cleaner code
    enum Move{ROCK, PAPER, SCISSOR}
    enum GameState{DRAW, PLAYER1WIN, PLAYER2WIN}

    // Address of players
    address payable player1;
    address payable player2;

    // Players moves
    Move player1move;
    Move player2move;

    // Players bets
    uint player1bet;
    uint player2bet;

    // Game outcome
    GameState outcome;

    bool winnerPaid = false;


    function play(address payable player, Move move) public payable returns(string memory) {
        // Check that the deposit is 1 ETH, if not revert
        if (msg.value != 1 ether){
            revert("1 ETH exactly is required!");
        } 

        // Check if player 1 has been assigned
        if (player1 == address(0)) {
            player1 = player;
            player1move = move;
            player1bet = msg.value;
            return "1 ETH deposited, you're player 1!";
        
        // Check if player 2 has been assigned
        } else if (player2 == address(0)) {
            player2 = player;
            player2move = move;
            player2bet = msg.value;
            return "1 ETH deposited, you're player 2!";
        } else {
            return "Both players have been assigned, wait for game to finish!";
        }
    }

    function decide() public view returns(string memory) {
        if (player1 != address(0) && player2 != address(0)) {
            // Check for Draw
            if (player1move == player2move) {
                if (!winnerPaid) payout;
                return "Draw!";

            // Check if player 1 won
            } else if (player1move == Move.ROCK && player2move == Move.SCISSOR ||
                       player1move == Move.PAPER && player2move == Move.ROCK ||
                       player1move == Move.SCISSOR && player2move == Move.PAPER) {
                           if (!winnerPaid) payout;
                           return "Player 1 wins!";
            } else {
                if (!winnerPaid) payout;
                return "Player 2 wins!";
            }
        } else {
            return "Wait for all players to move!";
        }
    }

    function payout() private {
        if (outcome == GameState.DRAW) {
            player1.transfer(1 ether);
            player2.transfer(1 ether);
        } else if (outcome == GameState.PLAYER1WIN) {
            player1.transfer(2 ether);
        } else {
            player2.transfer(2 ether);
        }
        winnerPaid = true;
    }

    function reset() public {
        delete player1;
        delete player1move;
        delete player2;
        delete player2move;
        winnerPaid = false;
    }

    function balance() external view returns(uint) {
        // Returns total value of contract
        return address(this).balance;
    }
}