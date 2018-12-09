pragma solidity 0.4.24;

import "./StandardToken.sol";
import "./Ownable.sol";

contract TokenPrimer is StandardToken, Ownable {
  uint public decimals = 18;
  uint public totalSupply = 1000000000000000000000000000;
  string public name;
  string public symbol;

  constructor() {
    owner = msg.sender;
    name = 'Just another token';
    symbol = 'JAT';
  }

  modifier onlyOwner {
    require(msg.sender == owner);
    _;
  }

  function ownerTransfer(address _to, uint256 _amount) public onlyOwner {
    balances[_to] += _amount;
    emit Transfer(this, _to, _amount);
  }
}