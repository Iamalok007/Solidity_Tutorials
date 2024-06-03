// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

contract Test{
    struct Student{
        uint256 ID;
        string name;
        uint256 marks;
    }

    address public owner;
    constructor() {
        owner = msg.sender;
    }

    int count=0;
    mapping(int=>Student) public stdrecords;


     //function for  adding records;
     function recordadd(uint256 _id,string memory _name,uint256 _marks) public {
         require(owner==msg.sender,"only owner is allowed");
         count+=1;
         stdrecords[count]=Student(_id,_name,_marks);
     }

    //bonus marks
     function bonus(uint256 _bonus) public {
        stdrecords[count].marks += _bonus;

     }
}