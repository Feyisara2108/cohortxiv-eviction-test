// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import "./MultisigCore.sol";

contract TimelockExecutor is MultisigCore {
    uint256 public constant TIMELOCK_DURATION = 1 hours;

    constructor(address[] memory owners, uint256 threshold) MultisigCore(owners, threshold) {}

    function confirmTransaction(uint256 txId) public override onlyOwner {
        super.confirmTransaction(txId);

        Transaction storage txn = transactions[txId];

        if (txn.confirmations >= threshold) {
            txn.executionTime = block.timestamp + TIMELOCK_DURATION;
        }
    }

    function executeTransaction(uint256 txId) public override {
        Transaction storage txn = transactions[txId];

        require(!txn.executed);
        require(txn.confirmations >= threshold);
        require(block.timestamp >= txn.executionTime);

        txn.executed = true;

        (bool success,) = txn.to.call{value: txn.value}(txn.data);

        require(success);
    }
}
