pragma solidity 0.4.24;

import './ERC721Token.sol';
import '../Ownable.sol';

contract Primer721 is ERC721Token('Primer721', 'P721'), Ownable {
  address owner;
  constructor() {
    owner = msg.sender;
  }
  function create(string _tokenUri) public {
    uint256 tokenId = allTokens.length + 1;
    _mint(msg.sender, tokenId);
    _setTokenURI(tokenId, _tokenUri);
  }
}