// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

contract Newsol {
 
 string _name;
 int _age;

 constructor (){
     _name="random";
     _age= 16;
 }

function getname() public view returns (string memory)
{
    return _name;
} 

function getage() public view returns (uint256){
    return uint256(_age);
}


}
