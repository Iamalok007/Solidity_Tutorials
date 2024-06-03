// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

contract MApping{

 //mapping
  mapping(uint => string) public names;
  mapping(uint => Mybook) public books;
  mapping(address => mapping(uint => Mybook)) public newbook;

   struct Mybook{
       string title;
       string name;

   }

  constructor(){
      names[1]="random";
      names[2]="another random name";
      names[3]="another anotehr name";
  }
  

  function readbooks(uint _id,string memory _title,string memory _name) public {
      books[_id]=Mybook(_title,_name);
  } 

  function newbookmap(uint _id,string memory _title,string memory _name) public {
      newbook[msg.sender][_id]=Mybook(_title,_name);
  }
}