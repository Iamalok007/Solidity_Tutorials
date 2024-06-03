// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

contract A{
    function message() public pure virtual returns(string memory){
        return "this is a sample message";
    }
}

contract B is A{
    function message() public pure override  returns(string memory){
        string memory x =super.message();
        return string(abi.encodePacked(x, "this is added text"));
    }
}