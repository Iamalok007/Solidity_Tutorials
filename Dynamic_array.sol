// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

contract Dynamic{
    int[] public values;

    function res(int _value) public {
     values.push(_value);
    }

    function getdata() public view returns(int[] memory){
        return values;
    } 
    function getlength() public view returns(uint){
        return values.length;
    }
    function getsum() public view returns(int) {
        uint i=0;
        int sum=0;
        for(i=0;i<values.length;i++)
        {
             sum=sum+values[i];

        }
        return sum;
    }
}