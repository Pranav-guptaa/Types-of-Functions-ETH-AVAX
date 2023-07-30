// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Requirements:
// 1. Only contract owner should be able to mint tokens
// 2. Any user can transfer tokens
// 3. Any user can burn tokens 

// Import necessary contracts from the OpenZeppelin library
import "@openzeppelin/contracts/token/ERC20/ERC20.sol"; // ERC20 contract for standard token functionalities
import "@openzeppelin/contracts/access/Ownable.sol"; // Ownable contract to handle ownership functionality

// Contract definition for the custom token
contract CustomToken is ERC20, Ownable {
    // Constructor function for initializing the token
    constructor(string memory name, string memory symbol) ERC20(name, symbol) {
        // Mint initial supply of tokens (10,00,000 tokens) to the contract deployer (owner)
        _mint(msg.sender, 1000000 * 10**18); // Token amount is multiplied by 10^18 to convert it to the smallest unit (wei) as per ERC20 standard
    }

    // Function to mint new tokens. Only the contract owner can call this function.
    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount); // Mint 'amount' tokens to the specified 'to' address
    }

    // Function to transfer tokens from one address to another. Overrides the ERC20 transfer function.
    function transfer(address recipient, uint256 amount) public override returns (bool) {
        _transfer(_msgSender(), recipient, amount); // Transfer 'amount' tokens from the sender to the 'recipient'
        return true; // Return 'true' to indicate a successful transfer
    }

    // Function to burn (destroy) tokens. Any user can burn their own tokens.
    function burn(uint256 amount) public {
        _burn(_msgSender(), amount); // Burn 'amount' tokens from the sender's balance
    }
}
