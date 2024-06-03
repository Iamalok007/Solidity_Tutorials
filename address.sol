// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

contract Address{
address public my_add;
constructor (){
  my_add=msg.sender;
}
function add() public view returns (bool){
return  msg.sender==my_add;
}
function returnbalance() public view returns (uint256){
    return my_add.balance;
}
}