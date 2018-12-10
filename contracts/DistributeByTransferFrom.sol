pragma solidity 0.4.24;

import "./StandardToken.sol";
import "./ERC721/ERC721Token.sol";
import "./Ownable.sol";

contract ERC20StdToken is StandardToken {}

contract ERC721StdToken is ERC721Token {}

contract DistributeByTransferFrom is Ownable {
  address public owner;

  constructor () public {
    owner = msg.sender;
  }

  modifier onlyOwner {
    require(msg.sender == owner);
    _;
  }
  event Pay(uint256 _value, bytes _id);
  
  /**
   * @dev fallback functiom that receives payment in ether and sends
   * it to the contract owner
  **/
  function () payable public {
    owner.transfer(msg.value);
    emit Pay(msg.value, msg.data);
  }
  /**
   * @dev sends transactions TransferFrom by cycle in token address
   * @param _token Address of token which is distributed
   * @param _bits Array of transfer params. nth elem - address to, nth+1 elem - value
  */
  function distributeTokens(address _token, address _from, uint256[] _bits) public onlyOwner returns (bool result) {
    require(_bits.length % 2 == 0);
    for (uint256 i = 0; i < _bits.length; i+=2) {
      address to = address(_bits[i]);
      uint256 value = _bits[i+1];
      ERC20StdToken(_token).transferFrom(_from, to, value);
    }
    return true;
  }
  /** 
   * @dev Sends accidentally sent ethereum from contract to owner
  */
  function withdrawEther() public onlyOwner returns(bool res) {
    uint256 ethBalance = address(this).balance;
    owner.transfer(ethBalance);
    return true;
  }
  /** 
   * @dev Withdraws any accidentally sent ERC20 token from contract to owner
   * @param _token Address of token to be withdrawed
  */
  function withdrawERC20(address _token) public onlyOwner returns(bool res) {
    uint256 value = ERC20StdToken(_token).balanceOf(address(this));
    ERC20StdToken(_token).transfer(owner, value);
    return true;
  }
  /** 
   * @dev Withdraws any accidentally sent ERC721 token from contract to owner
   * @param _contract Address of ERC721 token contract
   * @param _tokenId Id of non-fungible token to be withdrawed
  */
  function withdrawERC721(address _contract, uint256 _tokenId) public onlyOwner returns(bool res) {
    ERC721StdToken(_contract).safeTransferFrom(address(this), owner, _tokenId);
    return true;
  }
}