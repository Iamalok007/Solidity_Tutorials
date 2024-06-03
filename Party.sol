// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

contract Party{
    uint256 public depositAmount;
    address[] public people;

    constructor(){
        depositAmount= 1 ether;
    }

    function RSVP() external payable {
        require(msg.value == depositAmount,"please deposit correct amount");
        for (uint256 i = 0; i < people.length; i++) {
            require(people[i] != msg.sender, "You have already RSVP'd.");
        }

        people.push(msg.sender);
    }
    function peopleCt() external view returns (uint256) {
        return people.length;
    }

}