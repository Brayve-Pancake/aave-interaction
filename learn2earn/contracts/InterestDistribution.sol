// SPDX-License-Identifier: Unlicensed
pragma solidity 0.8.10;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract InterestDistribution {
    //0x8D211AfD3eE76Dbac6B545AFDc51CdaC92997D37 address of smart contract
    IERC20 aPolWMatic = IERC20(0x89a6AE840b3F8f489418933A220315eeA36d11fF);

    // Check the AdminContract balance
    function getBalance(address tokenHolder) external view returns (uint256) {
        return aPolWMatic.balanceOf(tokenHolder);
    }

    address[] public accounts;

    // record initial user input amount and time for interest calculations 
    mapping(address => uint256) initialDeposits;
    uint256 totalDeposits;
    mapping(address => uint256) blockNumberOnJoin;

    mapping(address => uint256) earnedInterest;

    // having both allows us to see if we have over allocated rewards
    uint256 totalInterestAllocated;
    uint256 totalInterestEarned;

    // have a time dedicated for the start of each reward window;
    uint256 OFFICIAL_START_TIME_24HR;

    // storage for total aTokens at the start of each time period
    mapping(uint256 => uint256) aTokensTotal;

    uint32 rewardPeriod;

    // USE chainLink keeper function to update on time 
    // If one day has passed or if a new user joins:
    function keeper() external {
    if( block.timestamp >= (OFFICIAL_START_TIME_24HR + 1day) || tranferFromNewUser() == true ) { // currently invalid || syntax
        rewardPeriod++;
        distributeFunds();
    }

    }

    function distributeFunds() internal {
        for (each account in the array) {
            uint percentShare = initialDeposits[account] / totalDeposits;
            aTokensToAllocate = aTokensEnd - aTokensStart;
            earnedInterest[account] += aTokensToAllocate * percentShare;
            //the first address will be the contract address, so it receives some interest
        }
        
    }
                    |-----|-----|-----|--\---|-----|
}

Keeper or no keeper?? 

// ping keeper?