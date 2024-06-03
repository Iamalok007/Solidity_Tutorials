// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@superfluid-finance/ethereum-contracts/contracts/interfaces/ISuperApp.sol"; // Updated Interface
import "@superfluid-finance/ethereum-contracts/contracts/interfaces/agreements/IConstantFlowAgreementV1.sol";
import "@superfluid-finance/ethereum-contracts/contracts/interfaces/tokens/IERC20WithTokenInfo.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract StreamContract is Ownable, ISuperApp {
  ISuperfluid private superfluid;
  IConstantFlowAgreementV1 private cfa;
  IERC20WithTokenInfo private token;

  constructor(address _superfluid, address _cfa, address _token) {
    superfluid = ISuperfluid(_superfluid);
    cfa = IConstantFlowAgreementV1(_cfa);
    token = IERC20WithTokenInfo(_token);
  }

  function createStream(address _receiver, uint256 _flowRate) external onlyOwner {
    require(_receiver != address(0), "Invalid receiver address");
    require(_flowRate > 0, "Flow rate must be greater than zero");

    // Approve super token transfer
    token.approve(address(cfa), _flowRate);

    // Create the flow
    superfluid.createFlow(_receiver, address(this), _flowRate, new bytes(0));

    // Start the flow
    cfa.createFlow(
      superfluid.getERC20WrapperAddress(token),
      _receiver,
      _flowRate,
      new bytes(0)
    );
  }

  function deleteStream(address _receiver) external onlyOwner {
    require(_receiver != address(0), "Invalid receiver address");

    // Delete the flow
    superfluid.deleteFlow(_receiver, address(this));

    // Stop the flow
    cfa.deleteFlow(
      superfluid.getERC20WrapperAddress(token),
      address(this),
      _receiver,
      new bytes(0)
    );
  }

  function getCurrentFlowRate(address _receiver) external view returns (int96) {
    return cfa.getFlowRate(
      superfluid.getERC20WrapperAddress(token),
      address(this),
      _receiver
    );
  }

  

