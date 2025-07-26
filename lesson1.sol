// Learning solidity

// This code is a simple example of how to use mappings and structs in Solidity to manage student records.
// It allows users to add their student information and retrieve it based on their address.
// The contract includes functions to add student data, retrieve individual student results, and get a list

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract mapping_example {
    //the Student struct is a structure (or custom data type) that acts as a blueprint for storing related student information — such as name, subject, and marks — as one unit.
    //Functions in the contract interact with this struct either to store new data, update existing data, or retrieve/display data based on the logic in the function.
    //The visibility specifier (like public, private, view, or pure) in those functions controls who can access them and how they interact with the contract’s state.
    // The data location specifier (like memory or storage) determines where the data is stored and how it can be accessed or modified.
    struct Student {
        string name;
        string subject;
        uint8 marks;
    }

    //    The mapping(address => Student) result; creates a mapping called result that links an address (the key) to a Student struct created above (the value).
    // This means each address can store and retrieve a specific Student record (e.g., name, subject, marks).

    // The address[] public student_result; creates a dynamic array of addresses called student_result.
    // Marking it as public automatically creates a getter function so external users or contracts can
    // access individual addresses stored in the array but if it is marked as private, the getter function will not be available and only the contract can access and modify it(e.g., student_result(0) returns the first stored address).
    mapping(address => Student) result;
    address[] public student_result;

    //The adding_values function allows users to add or update their student record. It accepts three inputs — the student's name, subject, and marks — and is marked public, meaning any external account can call it.
    //Inside the function,Student storage pupil creates a reference variable named pupil that points to the actual storage location of the Student struct associated with msg.sender. The if (bytes(pupil.name).length == 0) condition checks whether the student already exists by seeing if a name has been previously set.
    //If the name is empty, it implies this is a new student, so their address is added to the student_result array to track all unique entries. Finally, the function sets or updates the name, subject, and marks in the mapping for the caller’s address.
    function adding_values(
        string memory _name,
        string memory _subject,
        uint8 _marks
    ) public {
        Student storage pupil = result[msg.sender];
        if (bytes(pupil.name).length == 0) {
            student_result.push(msg.sender);
        }

        pupil.name = _name;
        pupil.subject = _subject;
        pupil.marks = _marks;
    }

    // The getStudentResult function takes in an address as an input and is marked as public meaning it can be accessed by anyone(external contracts, dapps, users), view meaning it can only be read and cannot be modified.
    // It retrieves the corresponding Student struct from the result mapping using the provided address and stores it in a temporary storage reference named pupil. The function then returns three values from that struct: the student's name (string), subject (string), and marks (uint8).
    // These values are returned directly as a tuple and can be viewed by anyone interacting with the contract, making this function useful for querying individual student results by their address.

    function getStudentResult(
        address studentAddress
    ) public view returns (string memory, string memory, uint8 marks) {
        Student storage pupil = result[studentAddress];
        return (pupil.name, pupil.subject, pupil.marks);
    }

    //The getAllStudentAddress function is a public view function, meaning it can be called by anyone and it does not modify the blockchain state.
    //It takes no parameters and returns an array of address values stored in student_result. When Solidity functions return arrays or complex data types,
    //the keyword memory specifies that the returned value is a copy of the original data stored in contract storage, not a reference. So in this case, student_result,
    //which is an array of addresses maintained in the contract, is copied to memory and returned.
    //This allows external users or applications to view all the addresses of students who have submitted results without changing anything on the blockchain.
    function getAllStudentAddress() public view returns (address[] memory) {
        return student_result;
    }
}
