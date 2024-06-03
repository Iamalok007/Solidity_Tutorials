// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

contract A{
    string internal x;

    function setstring() public  returns (string memory) {
        x="name";
        return x;
    }

}

contract B{
    uint internal m;
    function getmul(uint a, uint b) public pure returns(uint) {
        return a**b;

    }
}

contract C is B,A{
    B c = new B();
    A a = new A();

   string  q;
    uint y;

    function getResult() external returns(string memory) {
        q=a.setstring();
        y=c.getmul(7, 8);

        return q;
        
    }

  

}