// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface ITimelock {
    function executeTransaction(uint256 txId) external;
}
