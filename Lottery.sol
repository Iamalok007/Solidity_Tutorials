// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

contract Lottery{
    address public host;
    address payable[] public player; 

    constructor(){
        host=msg.sender;

    }

    function f() public payable {
        require(msg.value > 0.01 ether,"please enter sufficient ether ");
        player.push(payable(msg.sender));
    }

    function random() private view returns (uint256) {
    return uint256(keccak256(abi.encodePacked(block.difficulty, block.timestamp, player.length)));
    /*alternate to genrate a random hash*/
    /*return uint256(keccak256(abi.encodePacked(blockhash(block.number - 1), player.length)));*/
    }

    function winner() public {

        require(player.length>3, "participants need to be more than 3");
        require(msg.sender == host,"this can be accessed by host only");

        uint256 index = random() % player.length;
        address payable won = player[index];
        uint256 prizeAt = address(this).balance;

        won.transfer(prizeAt);

        player=new address payable[](0);

    }

    function playerreturn() public view returns(address payable[] memory){
        return player;
    }






}