//SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.10;

contract Hello_World { //contact Hello_World is the name of the contract i.e Messge

    string public message; 

    function setMessage(string memory _message) public {
        message = _message;
    }

    function viewMessage() public view returns(string memory){
        return message;
    }

    //The name of this function is setMessage wirrten in camelcasing. A string is passed to set the message, with message being that message
}
