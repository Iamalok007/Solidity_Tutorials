// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

contract Hotel{

     enum statuses {vacant,occupied}
     statuses public  currentstatus;

     event occupy(address _accupant, uint _value);

    address payable public owner;

    constructor(){
        owner=payable(msg.sender);
        currentstatus=statuses.vacant;
    }
    
    modifier onlyWhilevacant{
        require(currentstatus == statuses.vacant,"currently occupied");
        _;
    }

    modifier costs(uint _amount){
        require(_amount >=2 ether,"not enough ether provided");
        _;
    }


    function Book() public  payable onlyWhilevacant costs(2 ether)  {
        currentstatus=statuses.occupied;
        //owner.transfer(msg.value);
        ///////or///////
        (bool sent ,bytes memory data)= owner.call{value:msg.value}("");
        require(true);

        emit occupy(msg.sender,msg.value);
    }
}