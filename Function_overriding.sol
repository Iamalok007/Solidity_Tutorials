// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

contract A{
    function example(uint256 a, uint256 b) public virtual pure returns(uint256){
     return a+b;
  } 
}

contract B is A{
    function example(uint256 x, uint256 y) public pure override  returns(uint256){
        return A.example(x, y)+100;
    } 

}

// contract Overridingfunction{
//     A public a;
//     B public b;

//     constructor(){
//         a= new A();
//         b= new B();
//     }

//     function callingA(uint256 x1, uint256 x2) public view returns(uint256){
//         return a.example(x1, x2);
//     } 

//     function callinB(uint256 x, uint256 y) public view returns(uint256){
//         return b.example(x,y);
//     }


// }
