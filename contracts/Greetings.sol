//SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

contract Greeting{
    string public name;
    string public greetingPrefix = "Hello";

    constructor(string memory initialName) {
        name = initialName;
    }

    function setName(string memory newName) public {
        name = newName;
    }

    function getGreeting() public view returns(string memory){
        return string(abi.encodePacked(greetingPrefix, name));
    }

    string public message; 

    function setMessage(string memory _message) public {
        message = _message;
    }

    function viewMessage() public view returns(string memory){
        return message;
    }
}