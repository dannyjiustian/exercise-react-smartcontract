// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract SmartContract {
    // Struct to represent a transaction
    struct TransferStruct {
        address sender;         // Address of the sender
        address receiver;       // Address of the receiver
        uint256 amount;         // Amount of the transaction
        string message;         // Optional message associated with the transaction
        uint256 timestamp;      // Timestamp of the transaction
    }

    uint256 transactionCount;   // Counter for the total number of transactions
    TransferStruct[] transactions;  // Array to store all the transactions
    event Transfer(address indexed from, address indexed receiver, uint256 amount, string message, uint256 timestamp);

    // Function to add a transaction
    function addTransaction(uint256[6] memory limits, address payable[] memory receivers, string memory message) public payable {
        // Perform various checks and validations before proceeding with the transaction
        require(limits.length == 6, "Invalid limits array length");
        require(receivers.length > 0, "No receivers specified");
        require(msg.sender.balance > 0, "Insufficient balance");
        require(msg.value > 0, "Value not provided");

        // Calculate the amount to be split among the receivers
        uint256 amount = msg.value * 3 / 10;
        uint256 diffLimits = limits[1] - limits[0];
        uint256 splitAmount = amount / diffLimits;

        // Iterate through the specified limits and add transactions for each receiver
        for (uint256 i = limits[0]; i < limits[1]; i++) {
            _addTransaction(msg.sender, receivers[i], splitAmount, message);
            _transferEther(receivers[i], splitAmount);
        }

        // Repeat the same process for the next set of limits
        amount = msg.value * 1 / 10;
        diffLimits = limits[3] - limits[2];
        splitAmount = amount / diffLimits;

        for (uint256 i = limits[2]; i < limits[3]; i++) {
            _addTransaction(msg.sender, receivers[i], splitAmount, message);
            _transferEther(receivers[i], splitAmount);
        }

        // Repeat the same process for the final set of limits
        amount = msg.value * 6 / 10;
        diffLimits = limits[5] - limits[4];
        splitAmount = amount / diffLimits;

        for (uint256 i = limits[4]; i < limits[5]; i++) {
            _addTransaction(msg.sender, receivers[i], splitAmount, message);
            _transferEther(receivers[i], splitAmount);
        }
    }

    // Internal function to add a transaction to the array and emit an event
    function _addTransaction(address sender, address receiver, uint256 amount, string memory message) internal {
        transactionCount += 1;
        transactions.push(TransferStruct(sender, receiver, amount, message, block.timestamp));
        emit Transfer(sender, receiver, amount, message, block.timestamp);
    }

    // Internal function to transfer ether to a receiver
    function _transferEther(address payable receiver, uint256 amount) internal {
        (bool sent, ) = receiver.call{value: amount}("");
        require(sent, "Failed to send Ether");
    }

    // Function to get all the transactions
    function getAllTransaction() public view returns (TransferStruct[] memory) {
        return transactions;
    }

    // Function to get the total number of transactions
    function getTransactionCount() public view returns (uint256) {
        return transactionCount;
    }
}