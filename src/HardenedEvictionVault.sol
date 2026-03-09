// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./modules/MultisigCore.sol";
import "./modules/TimelockExecutor.sol";
import "./modules/MerkleAirdrop.sol";
import "./modules/PauseModule.sol";

contract HardenedEvictionVault is MultisigCore, TimelockExecutor, MerkleAirdrop, PauseModule {
    mapping(address => uint256) public balances;

    uint256 public totalVaultValue;

    event Deposit(address user, uint256 amount);
    event Withdrawal(address user, uint256 amount);

    receive() external payable {
        balances[msg.sender] += msg.value;
        totalVaultValue += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    function deposit() external payable {
        balances[msg.sender] += msg.value;
        totalVaultValue += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    function withdraw(uint256 amount) external whenNotPaused {
        require(balances[msg.sender] >= amount);

        balances[msg.sender] -= amount;

        totalVaultValue -= amount;

        (bool success,) = payable(msg.sender).call{value: amount}("");

        require(success);

        emit Withdrawal(msg.sender, amount);
    }
}
