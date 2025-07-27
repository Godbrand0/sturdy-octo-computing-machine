// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;


// This Solidity code demonstrates a simple ownership transfer mechanism using a contract called Ownable.
// The Ownable contract allows the deployer to set an owner address, restricts access to certain functions to the owner, and provides a way to transfer ownership to a new address.
contract Ownable {
    //This line declares a state variable named owner of type address.
    //It is marked public, which means Solidity will automatically generate a getter function so that other contracts or users can read its value.
    address public owner;

//This is a constructor, a special function in Solidity that is executed only once — at the time the contract is deployed to the blockchain. In this example, the constructor sets the owner state variable to msg.sender, which represents the address of the account or contract that deployed the contract.
    constructor() {
        owner = msg.sender;
    }

// This is a function modifier named onlyowner. It is used to restrict access to certain functions, 
// allowing only the owner of the contract (the address stored in the owner variable) to execute them. 
// It does this by checking if msg.sender — the address calling the function — is equal to owner. 
// If not, the transaction is reverted with the error message "not owner". the underscore (_) represents the body of the function that uses this modifier.
    modifier onlyowner() {
        require(msg.sender == owner, "not owner");
        _;
    }

// This function allows the current owner to transfer ownership of the contract to a new address.
// It is marked as external, meaning it can be called from outside the contract, and it takes one parameter, _newOwner, which is the address to which ownership will be transferred.
// The function first checks if the _newOwner address is not the zero address (0x0), which is a common practice to prevent accidental transfers to an invalid address.
// If the check passes, it updates the owner state variable to the new address provided by _newOwner effectively transferring ownership to the new address.
    function transferOwner(address _newOwner) external onlyowner {
        require(_newOwner != address(0), "invalid address");
        owner = _newOwner;
    }
}
