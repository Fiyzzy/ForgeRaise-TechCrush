A decentralized multi-model crowdfunding platform built on Ethereum. Builders, founders, and investors come together to fund ideas — transparently, on-chain, with no middleman.


🌍 What Problem Does ForgeRaise Solve?
Traditional crowdfunding platforms are:

Centralized — GoFundMe, Kickstarter control your funds
Single model — one platform, one funding type
Opaque — no transparency on where funds go
Exclusive — equity funding is only for the privileged few

ForgeRaise fixes all of this.

One platform. Three funding models. Everything on-chain. Anyone can participate.


🎯 How It Works
ForgeRaise supports 3 funding types — creators pick the model that fits their project:

Type
Who It's For
What Backers Receive
🤝 Donation
Charities, open source, social impact
ForgeNFT as proof of contribution
🎁 Reward
Startups, creators, builders
Creator's custom ERC20 token + ForgeNFT
⚖️ Equity
Serious founders raising investment
Equity tokens (proportional stake) + ForgeNFT

Token Rewards
1 ETH contributed = 1000 reward/equity tokens

2 ETH contributed = 2000 reward/equity tokens

More ETH = More tokens = Bigger stake in the project ✅
Platform Fee
ForgeRaise takes a 3% fee on every successful withdrawal — lower than Kickstarter (5%) and Indiegogo (5%).


🏗️ Project Structure
ForgeRaise/

├── src/

│   ├── ForgeRaise.sol      ← Main crowdfunding contract

│   ├── ForgeToken.sol      ← ERC20 token (proof of contribution)

│   └── ForgeNFT.sol        ← ERC721 NFT (unique per backer)

├── script/

│   └── Deploy.s.sol        ← Deployment script

├── test/

│   └── ForgeRaise.t.sol    ← Full test suite

├── foundry.toml

└── README.md


📄 Smart Contracts
ForgeRaise.sol — Main Contract
The heart of the platform. Handles:

Campaign creation (verified creators only)
Contributions (routes to correct funding type handler)
Withdrawals (with automatic 3% fee deduction)
Refunds (if campaign fails to reach goal)
Platform fee collection (owner only)
ForgeToken.sol — ERC20 Token
Inherited from OpenZeppelin ERC20
Creators deploy their OWN token and pass the address to ForgeRaise
Only ForgeRaise (as owner) can mint tokens to backers
Backers receive tokens proportional to their contribution
ForgeNFT.sol — ERC721 NFT
Inherited from OpenZeppelin ERC721
Every backer receives a unique NFT as proof of contribution
Token ID increments with every mint — no two NFTs are the same
Deployed automatically when ForgeRaise is deployed


🔐 Security Features
Feature
Implementation
Reentrancy Protection
OpenZeppelin ReentrancyGuard + CEI pattern
Access Control
OpenZeppelin Ownable + onlyVerifiedCreator modifier
Creator Verification
Light KYC — owner verifies once, creator is free forever
Double Withdrawal
withdrawn bool prevents creator withdrawing twice
Double Refund
refunded mapping prevents backer refunding twice
Safe ETH Transfer
.call() instead of .transfer()
Custom Errors
Gas-efficient errors with context info

CEI Pattern (Checks-Effects-Interactions)
Every function that sends ETH follows this pattern:

1. CHECK  → validate all conditions

2. EFFECT → update all state variables

3. INTERACT → send ETH last

This prevents reentrancy attacks even without nonReentrant.


⛽ Gas Optimizations
constant variables → baked into bytecode, zero gas to read
calldata for string parameters → cheaper than memory
external instead of public → cheaper for functions not called internally
Custom errors → cheaper than require strings
Cached storage reads → Campaign memory campaign = campaigns[id]
Nested mappings → efficient multi-dimensional data storage


🚀 How To Deploy
Prerequisites
Foundry installed
Sepolia ETH in your wallet (faucet)
RPC URL from Alchemy or Infura
1. Clone the repo
git clone https://github.com/YOUR_USERNAME/ForgeRaise

cd ForgeRaise
2. Install dependencies
forge install OpenZeppelin/openzeppelin-contracts
3. Set up environment variables
Create a .env file:

PRIVATE_KEY=your_private_key_here

SEPOLIA_RPC_URL=your_sepolia_rpc_url

ETHERSCAN_API_KEY=your_etherscan_api_key
4. Build the contracts
forge build
5. Deploy to Sepolia
forge script script/Deploy.s.sol:DeployForgeRaise \

  --rpc-url $SEPOLIA_RPC_URL \

  --private-key $PRIVATE_KEY \

  --broadcast \

  --verify \

  --etherscan-api-key $ETHERSCAN_API_KEY \

  -vvvv


🧪 How To Run Tests
Run all tests
forge test
Run with console logs visible
forge test -vv
Run with full traces
forge test -vvvv
Run a specific test
forge test --match-test test_CreatorCanWithdrawAfterGoalReached -vv


📋 Test Coverage
Category
Tests
Owner Functions
Verify creator, Revoke creator, Non-owner cannot verify
Campaign Creation
Verified creator creates, Unverified fails, Zero goal fails, Short deadline fails
Contributions
Backer contributes, Receives NFT, Receives tokens + NFT, Below minimum fails, Creator cannot contribute, Goal reached event
Withdrawals
Creator withdraws, Platform fee accumulated, Cannot withdraw twice, Cannot withdraw if goal not reached
Refunds
Backer refunded after failure, Cannot refund before deadline, Cannot refund twice
Platform Fees
Owner withdraws fees, Non-owner cannot withdraw fees



📖 Contract Interaction Guide
As the Platform Owner
1. Verify a creator

forgeRaise.verifyCreator(creatorAddress);

2. Revoke a creator

forgeRaise.revokeCreator(creatorAddress);

3. Withdraw platform fees

forgeRaise.withdrawFees();


As a Creator
1. Deploy your own reward token first

ForgeToken myToken = new ForgeToken();

2. Transfer token ownership to ForgeRaise

myToken.transferOwnership(address(forgeRaise));

3. Create your campaign

forgeRaise.createCampaign(

    "My AI Agent Project",          // name

    "Building an AI agent on-chain", // description

    10 ether,                        // goal

    block.timestamp + 60 days,       // deadline

    0.1 ether,                       // minimum contribution

    FundingType.Reward,              // funding type

    address(myToken)                 // your reward token address

);

4. Withdraw after goal is reached

forgeRaise.withdraw(campaignId);

// You receive 97% — ForgeRaise keeps 3%


As a Backer
1. Contribute ETH to a campaign

forgeRaise.contribute{value: 1 ether}(campaignId);

// You automatically receive tokens + NFT based on campaign type

2. Get refund if campaign fails

// Only works after deadline AND goal not reached

forgeRaise.refund(campaignId);


🔮 Future Roadmap
🌐 DApp Frontend — React/Next.js interface for ForgeRaise
📊 Campaign Analytics — track contributions over time
🗳️ Milestone-based Funding — release funds in stages via backer voting
💰 Multi-token Support — accept USDC, DAI not just ETH
🏷️ Campaign Categories — filter by startup, charity, creative
📱 Push Notifications — wallet-based alerts via Push Protocol
🔄 Secondary Market — trade contribution NFTs on-chain


📝 Deployed Contracts (Sepolia Testnet)
Contract
Address
Etherscan
ForgeRaise
TBD after deployment
View
ForgeNFT
TBD after deployment
View



👤 Author
Fiyinfoluwa Babaagba Techcrush Cohort 6 — Personal Capstone Project


📜 License
MIT License — see LICENSE for details.
