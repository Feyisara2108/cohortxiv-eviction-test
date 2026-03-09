// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface ITimelock {
    function executeAfterTimelock(uint256 txId) external;
}
