// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

contract New{
    struct Students{
        string Name;
        uint Roll;
        uint Class;
    }

    Students student;

    function put() public {
        student= Students('amit',26,12);

    }
    function getvalue() public view returns (uint){
           return student.Class;
    }
}