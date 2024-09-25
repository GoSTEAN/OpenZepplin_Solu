// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Hack {
    function recover(address sender) external pure returns (address) {
        address addr = address(uint160(uint256(
                        keccak256(abi.encodePacked(
                            bytes1(0xd6), bytes1(0x94), sender, bytes1(0x01)
                        ))
                    )));
        return addr;
    }
}

contract Recovery {
    //generate tokens
    function generateToken(string memory _name, uint256 _initialSupply) public {
        new SimpleToken(_name, msg.sender, _initialSupply);
    }
}

contract SimpleToken {
    string public name;
    mapping(address => uint256) public balances;

    // constructor
    constructor(string memory _name, address _creator, uint256 _initialSupply) {
        name = _name;
        balances[_creator] = _initialSupply;
    }

    // collect ether in return for tokens
    receive() external payable {
        balances[msg.sender] = msg.value * 10;
    }

    // allow transfers of tokens
    function transfer(address _to, uint256 _amount) public {
        require(balances[msg.sender] >= _amount);
        balances[msg.sender] = balances[msg.sender] - _amount;
        balances[_to] = _amount;
    }

    // clean up after ourselves
    function destroy(address payable _to) public {
        selfdestruct(_to);
    }
}

// 0xD9689bbb8449178140D5fd4f4F1717eCb5469888


// 0x98a736dEf28De14739A14FdDbE6d3ED761C56BA0