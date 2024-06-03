// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RoomManager {
  // Mapping to store users who joined a room
  mapping(string => address[]) public rooms;

  // Function for users to join a room
  function joinRoom(string memory roomCode) public {
    address[] storage participants = rooms[roomCode]; // Get the room participants

    // Check if the room is already full (2 users)
    require(participants.length < 2, "Room is already full.");
    rooms[roomCode].push(msg.sender); // Add user's address to the room
  }

  // Optional transfer function between users within a room (not secure, for demonstration)
  function transfer(address recipient, uint amount) public payable {
    require(msg.value >= amount, "Insufficient funds");
    payable(recipient).transfer(amount); // Transfer funds directly
  }
}
