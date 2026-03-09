// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

interface IAirdrop {
    function setMerkleRoot(bytes32 root) external;

    function claim(bytes32[] calldata proof, uint256 amount) external;
}
