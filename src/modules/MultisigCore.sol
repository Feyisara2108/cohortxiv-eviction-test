// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "../interfaces/IMultisig.sol";

contract MultisigCore is IMultisig {
    mapping(address => bool) public isOwner;
    address[] public owners;

    uint256 public threshold;

    mapping(uint256 => mapping(address => bool)) public confirmed;
    mapping(uint256 => Transaction) public transactions;

    uint256 public txCount;

    modifier onlyOwner() {
        require(isOwner[msg.sender], "not owner");
        _;
    }

    constructor(address[] memory _owners, uint256 _threshold) {
        require(_owners.length > 0);
        require(_threshold <= _owners.length);

        for (uint256 i; i < _owners.length; i++) {
            isOwner[_owners[i]] = true;
            owners.push(_owners[i]);
        }

        threshold = _threshold;
    }

    function submitTransaction(address to, uint256 value, bytes calldata data)
        public
        override
        onlyOwner
        returns (uint256)
    {
        uint256 txId = txCount++;

        transactions[txId] = Transaction(to, value, data, false, 1, block.timestamp, 0);

        confirmed[txId][msg.sender] = true;

        return txId;
    }

    function confirmTransaction(uint256 txId) public override onlyOwner {
        Transaction storage txn = transactions[txId];

        require(!txn.executed);
        require(!confirmed[txId][msg.sender]);

        confirmed[txId][msg.sender] = true;

        txn.confirmations++;
    }

    function executeTransaction(uint256) public virtual override {}
}
