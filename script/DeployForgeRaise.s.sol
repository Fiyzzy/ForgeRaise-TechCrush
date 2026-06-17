// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/ForgeRaise.sol";

contract DeployForgeRaise is Script {

    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(deployerPrivateKey);

        // 1. Deploy ForgeRaise (auto-deploys ForgeNFT inside constructor)
        ForgeRaise forgeRaise = new ForgeRaise();
        console.log("ForgeRaise deployed at:", address(forgeRaise));
        console.log("ForgeNFT deployed at:", address(forgeRaise.forgeNFT()));

        // 2. Deploy a sample ForgeToken
        ForgeToken forgeToken = new ForgeToken();
        console.log("ForgeToken deployed at:", address(forgeToken));

        vm.stopBroadcast();
    }
}