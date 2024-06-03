// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

contract Caclculator{
   /*
   string printing :=>

    string text;
   
 function   printstring() public returns(string memory){
  text="thsi is alok";
  return text;
 }
*/

uint c;
 function add(uint a,uint b) public {
     c=a+b;
 }
 
 function sub(uint a,uint b) public {
     c=a-b;
 }
 function mul(uint a,uint b) public {
     c=a*b;
 }
 function div(uint a,uint b) public {
     c=a/b;
 }


function inc(uint a) public {
     c=a+1;
 }
 function dec(uint a) public {
     c=a-1;
 }
  function result() public view returns (uint){
     return c;
 }




}