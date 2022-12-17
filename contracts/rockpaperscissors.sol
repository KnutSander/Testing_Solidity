// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract RockPaperScissors {

    uint8 constant R = 0; // ROCK
    uint8 constant P = 1; // PAPER
    uint8 constant S = 2; // SCISSORS

    address[2] public players;

    uint private turn = 0;
    
    mapping(address => uint8) private choices;

    // Matrix containing result of the game depending on its states
    mapping(uint8 => mapping(uint8 => uint8)) private states;

    constructor() {
        // Initialize game outcomes
        states[R][R] = 0; // tie
        states[R][P] = 2; // player 2 wins
        states[R][S] = 1; // player 1 wins
        states[P][R] = 1; // player 1 wins
        states[P][P] = 0; // tie
        states[P][S] = 2; // player 2 wins 
        states[S][R] = 2; // player 2 wins
        states[S][P] = 1; // player 1 wins
        states[S][S] = 0; // tie
    }

    function play(address player, uint8 choice) external {
        // Ensure that only the first two choices are recorded
        if (turn < 2) { 
            players[turn] = player;
            choices[player] = choice;
            turn++;
        }
    }

    function decide() external returns (address) {
        address winner = address(0);

        // Default to a tie if not two players submitted their decisions
        if (turn != 2) { 
            return winner;
        }

        // Determine winner
        uint8 result = states[choices[players[0]]][choices[players[1]]];
        
        if (result == 1 || result == 2) {
            winner = players[result-1];
        }

        // Reset game for the next round
        players[0] = address(0);
        players[1] = address(0); 
        turn = 0;

        // Return result
        return winner;
    }
}
