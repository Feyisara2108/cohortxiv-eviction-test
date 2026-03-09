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
}
