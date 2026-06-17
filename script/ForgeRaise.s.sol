// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/ForgeRaise.sol";

contract DeployForgeRaise is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        // Goal: 1 ETH, Duration: 30 days
        ForgeRaise forgeRaise = new ForgeRaise(1 ether, 30);
        console.log("ForgeRaise deployed at:", address(forgeRaise));
        console.log("ForgeToken deployed at:", address(forgeRaise.forgeToken()));
        console.log("ForgeNFT deployed at:", address(forgeRaise.forgeNFT()));

        vm.stopBroadcast();
    }
}
