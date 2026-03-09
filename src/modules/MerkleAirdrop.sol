// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";

contract MerkleAirdrop {
    bytes32 public merkleRoot;

    mapping(address => bool) public claimed;

    function setMerkleRoot(bytes32 root) external {
        merkleRoot = root;
    }

    function claim(bytes32[] calldata proof, uint256 amount) external {
        bytes32 leaf = keccak256(abi.encodePacked(msg.sender, amount));

        require(MerkleProof.verify(proof, merkleRoot, leaf), "invalid proof");

        require(!claimed[msg.sender]);

        claimed[msg.sender] = true;

        (bool success,) = payable(msg.sender).call{value: amount}("");

        require(success);
    }
}
