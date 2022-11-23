// SPDX-License-Identifier: GPL-3.0
// Basic rock-paper-scissors in Solidity

pragma solidity >=0.7.0 <0.9.0;

contract RPS_v1 {

    enum Move{ROCK, PAPER, SCISSOR}

    address player1;
    address player2;

    Move player1move;
    Move player2move;

    function play(address player, Move move) public returns(string memory) {
        if (player1 == address(0)) {
            player1 = player;
            player1move = move;
            return "You're player 1!";
        } else if (player2 == address(0)) {
            player2 = player;
            player2move = move;
            return "You're player 2!";
        } else {
            return "Both players have been assigned, wait for game to finish!";
        }
    }

    function decide() public view returns(string memory) {
        if (player1 != address(0) && player2 != address(0)) {
            // Check for Draw
            if (player1move == player2move) {
                return "Draw!";

            // Check if player 1 won
            } else if (player1move == Move.ROCK && player2move == Move.SCISSOR ||
                       player1move == Move.PAPER && player2move == Move.ROCK ||
                       player1move == Move.SCISSOR && player2move == Move.PAPER){
                           return "Player 1 wins!";
            } else {
                return "Player 2 wins!";
            }
        } else {
            return "Wait for all players to move!";
        }
    }

    function reset() public {
        delete player1;
        delete player1move;
        delete player2;
        delete player2move;
    }
}