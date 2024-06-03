
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

// Uncomment this line to use console.log
//import "hardhat/console.sol";

contract Transactions{
uint256 TransactionsCount;

event Transfer(address receiver,uint amount,string message,string keyword);

struct TransaferStruct{
    address receiver;
    uint amount;
    string message;
    string keyword;
}

 TransaferStruct[] transactions;

 function addToBlockchian(address payable receiver,uint amount,string memory message,string memory keyword)public{
    require(receiver != address(0), "Invalid receiver address");
    require(amount > 0, "Amount must be greater than zero");
    
    TransactionsCount+=1;
    transactions.push(TransaferStruct(receiver,amount,message,keyword));

    emit Transfer(receiver,amount,message,keyword);

 }

 function getAllTransactions() public view returns(TransaferStruct[] memory) {
    return transactions;
 }

 function getTransactionCount()public view returns(uint256){
return TransactionsCount;
 }
}