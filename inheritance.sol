//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

// This Solidity code demonstrates simple contract inheritance and composability. The parent contract defines a function to calculate and store a sum, while the child contract inherits from it and exposes a way to read that sum. 
//Finally, the caller contract creates an instance of the child contract, showing how one contract can interact with another by calling inherited functions to perform and retrieve computations.

contract parent {
    // this declares a state varible sum with type uint,  with a visibility modifier of internal meaning it can be
    //accessed by the contract and derived contracts but not externally.
    uint internal sum;

    //The setValue() function is an external function, meaning it can be called from outside the contract, such as from other contracts or externally through a transaction.
    //It creates two numbers (a and b), adds them together, and stores the result in the internal state variable sum.
    function setValue() external {
        uint a = 10;
        uint b = 20;
        sum = a + b;
    }
}


// The child contract inherits from the parent contract using IS. 
//It defines an external, read-only (view) function called getValue() that returns the sum variable stored in the parent contract.
contract child is parent {
    function getValue() external view returns (uint) {
        return sum;
    }
}

// In the caller contract, a new instance of the child contract is created and assigned to the variable cc. 
//This allows caller to interact with the child contract programmatically. The function testInheritance() is marked as public, meaning it can be called from within the contract or externally. 
//Inside this function, it first calls cc.setValue(), which adds two numbers and stores the result in the inherited sum variable from the parent contract.
//Then, it returns the result using cc.getValue(), which is defined in the child contract.

contract caller {
    child cc = new child();

    function testInheritance() public returns (uint) {
        cc.setValue();
        return cc.getValue();
    }
}
