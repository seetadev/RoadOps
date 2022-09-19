// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.7.6;

contract HelloWorld {
    string public message = "first message";

    function update(string memory newMessage) public {
        message = newMessage;
    }
}
