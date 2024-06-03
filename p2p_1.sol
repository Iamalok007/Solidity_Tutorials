// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@hashgraph/hedera-sdk-solidity/contracts/HTS.sol";

contract EnergyTokenContract {

  // Address of the authorized account for minting
  address public authorizedMinter;

  HTS.Token public energyToken;

  constructor(address _tokenContractAddress, address _authorizedMinter) public {
    energyToken = HTS.Token(_tokenContractAddress);
    authorizedMinter = _authorizedMinter;
  }

  // Function to create energy tokens (restricted to authorized minter)
  function createEnergyTokens(uint256 amount) external {
    require(msg.sender == authorizedMinter, "Not Authorized to Mint");
    energyToken.mint(msg.sender, amount);
  }

  // Function to transfer energy tokens
  function transferEnergyTokens(address recipient, uint256 amount) external {
    energyToken.transferFrom(msg.sender, recipient, amount);
  }

  // Function to simulate burning (transfer to a burn address)
  // (replace with a real burning mechanism in the future)
  function burnEnergyTokens(uint256 amount) external {
    // Replace with your Hedera account for "burning"
    address burnAddress = YOUR_BURN_ACCOUNT_ADDRESS;
    energyToken.transferFrom(msg.sender, burnAddress, amount);
  }

  function getTokenBalance(address account) external view returns (uint256) {
    return energyToken.balanceOf(account);
  }
}
