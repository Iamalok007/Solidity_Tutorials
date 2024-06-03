// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

contract Counter{
    uint count;
    
    constructor()
    {
        count=0;
    }
    function display() public view returns(uint){
        return count;
    }

    function incrementcount() public{
        count =count+1;
    }

}