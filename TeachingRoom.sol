//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/token/ERC1155/utils/ERC1155Holder.sol";

contract RoomContract is ERC1155, ERC1155Holder {
    //constructor() ERC1155("") {}

    function supportsInterface(bytes4 interfaceId)
        public
        view
        virtual
        override(ERC1155, ERC1155Holder)
        returns (bool)
    {
        return ERC1155.supportsInterface(interfaceId) || ERC1155Holder.supportsInterface(interfaceId);
    }

    address payable public owner;

    struct Room {
        address host;
        string title;
        string description;
        uint256 capacity;
        uint256 startTime;
        uint256 endTime;
        uint256 roomId;
        uint256 tokenId;
        uint256 currentParticipants;
    }

    uint256 public roomIdCounter;
    uint256 public tokenIdCounter;

    mapping(uint256 => Room) public rooms;

    constructor() ERC1155("") {
        owner = payable(msg.sender);
    }

    function createRoom(string memory _title, string memory _description, uint256 _capacity, uint256 _startTime, uint256 _endTime) public {
        roomIdCounter++;
        tokenIdCounter++;

        // Mint ERC1155 token representing the room
        _mint(address(this), tokenIdCounter, _capacity, "");

        rooms[roomIdCounter] = Room({
            host: msg.sender,
            title: _title,
            description: _description,
            capacity: _capacity,
            startTime: _startTime,
            endTime: _endTime,
            roomId: roomIdCounter,
            tokenId: tokenIdCounter,
            currentParticipants: 0
        });
    }

    function listRooms() public view returns (Room[] memory) {
        Room[] memory roomList = new Room[](roomIdCounter);
        for (uint256 i = 1; i <= roomIdCounter; i++) {
            roomList[i - 1] = rooms[i];
        }
        return roomList;
    }

    function joinRoom(uint256 _roomId) public payable {
        Room storage room = rooms[_roomId];
        require(room.currentParticipants < room.capacity, "Room is full");
        require(msg.value > 0, "Payment required to join room");

        // Transfer ERC1155 token representing the room to the participant
        _safeTransferFrom(address(this), msg.sender, room.tokenId, 1, "");

        room.currentParticipants++;
    }

    function myRooms(address _participant) public view returns (Room[] memory) {
        uint256 counter = 0;
        Room[] memory participantRooms = new Room[](roomIdCounter);

        for (uint256 i = 1; i <= roomIdCounter; i++) {
            Room storage room = rooms[i];
            if (balanceOf(_participant, room.tokenId) > 0) {
                participantRooms[counter] = room;
                counter++;
            }
        }
        return participantRooms;
    }

    function withdraw() public {
        require(msg.sender == owner, "Only owner can withdraw");
        payable(owner).transfer(address(this).balance);
    }
}
