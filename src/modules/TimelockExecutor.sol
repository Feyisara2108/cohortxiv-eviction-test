// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./MultisigCore.sol";

contract TimelockExecutor is MultisigCore {
    uint256 public constant TIMELOCK_DURATION = 1 hours;

    function executeAfterTimelock(uint256 txId) public {
        Transaction storage txn = transactions[txId];

        require(txn.confirmations >= threshold);
        require(block.timestamp >= txn.executionTime);
        require(!txn.executed);

        txn.executed = true;

        (bool success,) = txn.to.call{value: txn.value}(txn.data);

        require(success);
    }
}
