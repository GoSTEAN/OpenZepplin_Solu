// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// 0x7B1A4902E8be715e1b19CDEC532047A41f2334eF

contract Hack {
    constructor(MagicNum target) {
        bytes memory bytecode = hex"6960ff60005260206000f3600052600a6016f3";
        address addr;

        assembly {
            // create(value, offset, size)
            addr := create(0, add(bytecode, 0x20), 0x13)
        }
        require(addr != address(0));

        target.setSolver(addr);
    }

    // function attack() public {
    //     bytes memory bytecode = hex"600a600c600039600a6000f3602a60005260206000f3";
    //     bytes32 salt = 0;
    //     address solver;

    //     assembly {
    //         solver := create2(0, add(bytecode, 0x20), mload(bytecode), salt)
    //     }

    //     challenge.setSolver(solver);
    // }

}

contract MagicNum {
    address public solver;

    constructor() {}

    function setSolver(address _solver) public {
        solver = _solver;
    }

    /*
    ____________/\\\_______/\\\\\\\\\_____        
     __________/\\\\\_____/\\\///////\\\___       
      ________/\\\/\\\____\///______\//\\\__      
       ______/\\\/\/\\\______________/\\\/___     
        ____/\\\/__\/\\\___________/\\\//_____    
         __/\\\\\\\\\\\\\\\\_____/\\\//________   
          _\///////////\\\//____/\\\/___________  
           ___________\/\\\_____/\\\\\\\\\\\\\\\_ 
            ___________\///_____\///////////////__
    */
}
