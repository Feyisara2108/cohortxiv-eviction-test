// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

interface ITimelock {
    function executeTransaction(uint256 txId) external;
}
