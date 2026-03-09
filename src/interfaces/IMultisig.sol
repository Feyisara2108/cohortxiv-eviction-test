// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

interface IMultisig {
    struct Transaction {
        address to;
        uint256 value;
        bytes data;
        bool executed;
        uint256 confirmations;
        uint256 submissionTime;
        uint256 executionTime;
    }

    function submitTransaction(address to, uint256 value, bytes calldata data) external returns (uint256);

    function confirmTransaction(uint256 txId) external;

    function executeTransaction(uint256 txId) external;
}
