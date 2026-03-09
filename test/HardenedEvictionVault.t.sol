// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/HardenedEvictionVault.sol";

contract VaultTest is Test {
    HardenedEvictionVault vault;

    address owner1 = address(1);
    address owner2 = address(2);
    address user = address(3);

    function setUp() public {
        address;

        owners[0] = owner1;
        owners[1] = owner2;

        vault = new HardenedEvictionVault(owners, 2);
    }

    function testDeposit() public {
        vm.deal(user, 1 ether);

        vm.prank(user);
        vault.deposit{value: 1 ether}();

        assertEq(vault.balances(user), 1 ether);
    }

    function testWithdraw() public {
        vm.deal(user, 1 ether);

        vm.prank(user);
        vault.deposit{value: 1 ether}();

        vm.prank(user);
        vault.withdraw(1 ether);

        assertEq(vault.balances(user), 0);
    }

    function testPause() public {
        vault.pause();

        assertTrue(vault.paused());
    }

    function testSubmitTransaction() public {
        vm.prank(owner1);

        uint256 txId = vault.submitTransaction(address(1), 0, "");

        assertEq(txId, 0);
    }

    function testConfirmTransaction() public {
        vm.prank(owner1);

        uint256 txId = vault.submitTransaction(address(1), 0, "");

        vm.prank(owner2);

        vault.confirmTransaction(txId);

        (,,,, uint256 conf,,) = vault.transactions(txId);

        assertEq(conf, 2);
    }
}
