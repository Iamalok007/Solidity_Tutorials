// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

contract A{
    function add(uint a,uint b) public pure returns(uint){
        return a+b;
    }
}

contract B is A{
    uint private result;
    function getadd() public {
        result = add(7,11);
    }

    function getresult() public view returns(uint) {
        return result;
    }

    function getsub(uint x,uint y) public pure returns(uint){
        return x-y;

    }


}

contract C is B {
    uint res;
    function getsub() public {
        res = getsub(9, 13);
    }

    function newres() public view returns(uint){
        return res; 
    }
    uint rest;
    function gettingadd() public {
        rest=add(4,5);
    }

    function newsetres() public view returns (uint){
        return rest;
    }

    
    
}

