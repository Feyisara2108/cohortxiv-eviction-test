// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import "forge-std/Script.sol";
import "../src/HardenedEvictionVault.sol";

contract DeployVault is Script {
    function run() external {
        address owner1 = 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266;
        address owner2 = 0x70997970C51812dc3A010C7d01b50e0d17dc79C8;
        address owner3 = 0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC;

        address[] memory owners = new address[](3);
        owners[0] = owner1;
        owners[1] = owner2;
        owners[2] = owner3;

        uint256 threshold = 2;

        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(deployerPrivateKey);

        HardenedEvictionVault vault = new HardenedEvictionVault(owners, threshold);

        console.log("HardenedEvictionVault deployed at:", address(vault));
        console.log("Owners:");
        console.log("  [0]", owner1);
        console.log("  [1]", owner2);
        console.log("  [2]", owner3);
        console.log("Threshold:", threshold);

        vm.stopBroadcast();
    }
}
