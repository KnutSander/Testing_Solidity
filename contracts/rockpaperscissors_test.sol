// SPDX-License-Identifier: GPL-3.0
    
pragma solidity >=0.7.0 <0.9.0;

import "remix_tests.sol"; 
import "remix_accounts.sol";
import "../contracts/rockpaperscissors.sol";

contract testSuite {

    RockPaperScissors rps;

    uint8 constant R = 0; // ROCK
    uint8 constant P = 1; // PAPER
    uint8 constant S = 2; // SCISSORS

    address[2] public players;

    function beforeAll() public {
        players[0] = TestsAccounts.getAccount(0);
        players[1] = TestsAccounts.getAccount(1);
        rps = new RockPaperScissors();
    }

    function checkSuccess() public {
        rps.play(players[0], R); 
        rps.play(players[1], R);
        Assert.equal(rps.decide(), address(0), "should be a tie");
        rps.play(players[0], P); 
        rps.play(players[1], S);
        Assert.equal(rps.decide(), players[1], "player 2 should win");
        rps.play(players[0], R); 
        rps.play(players[1], S);
        Assert.equal(rps.decide(), players[0], "player 1 should win");
        rps.play(players[0], R); 
        rps.play(players[1], P);
        Assert.equal(rps.decide(), players[1], "player 2 should win");
    }

}
