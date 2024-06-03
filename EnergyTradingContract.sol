// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract EnergyTradingContract is Ownable {
    IERC20 public energyToken;

    event TokensPurchased(address buyer, uint256 amount);
    event TokensSold(address seller, uint256 amount);

     constructor(address _energyToken, address initialOwner) Ownable(initialOwner) {
        energyToken = IERC20(_energyToken);
    }

    function buyTokens(uint256 amount) external payable {
        require(msg.value > 0, "Invalid amount of Ether sent");
        uint256 tokenBalance = energyToken.balanceOf(address(this));
        require(tokenBalance >= amount, "Not enough tokens in contract");

        // Transfer tokens to buyer
        energyToken.transfer(msg.sender, amount);

        emit TokensPurchased(msg.sender, amount);
    }

    function sellTokens(uint256 amount) external {
        require(amount > 0, "Invalid amount of tokens to sell");
        uint256 tokenBalance = energyToken.balanceOf(msg.sender);
        require(tokenBalance >= amount, "Not enough tokens owned by seller");

        // Transfer tokens to contract
        energyToken.transferFrom(msg.sender, address(this), amount);

        // Transfer Ether to seller
        uint256 etherAmount = calculateEtherAmount(amount);
        payable(msg.sender).transfer(etherAmount);

        emit TokensSold(msg.sender, amount);
    }

    function calculateEtherAmount(uint256 amount) internal pure returns (uint256) {
        // Add your logic to calculate Ether amount based on token amount
        // For simplicity, let's assume 1 token = 0.001 Ether
        return amount * 1e15;
    }

    // Owner functions for managing the energy token contract address

    function setEnergyTokenAddress(address _energyToken) external onlyOwner {
        energyToken = IERC20(_energyToken);
    }

    function withdrawEther(uint256 amount) external onlyOwner {
        require(amount <= address(this).balance, "Insufficient Ether balance");
        payable(owner()).transfer(amount);
    }
}
