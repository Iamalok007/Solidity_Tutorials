// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

contract Arrays{
 
  uint[] public arrays=[1,2,3,4,5,6];
  string[] public atringarray=["hello","nice","good"];
  string[] public values;
  uint[][] public array2d=[[1,2,3],[4,5,6]];

  function addvalue(string memory _value) public {
      values.push(_value);
  }

  function count() public view returns(uint) {
    return values.length;
  }

}