// SPDX-License-Identifier: MIT

pragma solidity  ^0.8.19;

contract SimpleStorage {
  uint256 myFavouriteNumber;

  struct Person {
    uint256 favoriteNumber;
    string name;
  }

  Person[] public listOfPeople;
  
  mapping(string => uint256) public nameToFavouriteNumber;

  function store(uint256 _favouriteNumber) public {
    myFavouriteNumber = _favouriteNumber;
  }

  function retieve() public view returns (uint256) {
    return myFavouriteNumber;
  }

  function addPerson(string memory _name, uint256 _favouriteNumber) public {
    listOfPeople.push(Person(_favouriteNumber, _name));
    nameToFavouriteNumber[_name] = _favouriteNumber;
  }
}