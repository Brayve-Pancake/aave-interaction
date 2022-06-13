// SPDX-License-Identifier: Unlicensed
pragma solidity 0.8.10;

import "@aave/core-v3/contracts/interfaces/IPool.sol";
import "@aave/core-v3/contracts/interfaces/IPoolAddressesProvider.sol";

// Cannot us below format with hardhat
// import {IPoolAddressesProvider} from "https://github.com/aave/aave-v3-core/contracts/interfaces/IPoolAddressesProvider.sol";
// import {IPool} from "https://github.com/aave/aave-v3-core/blob/master/contracts/interfaces/IPool.sol";

// Used for testing
// import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol"; 88888888888 are these the same thing??????
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "hardhat/console.sol";

contract AaveInteraction {
    // Create varialbes to store pool address
    IPoolAddressesProvider public immutable ADDRESSES_PROVIDER;
    IPool public immutable POOL;
    address public immutable ADDRESS_WETH;

    address owner;
    // WETH on mumbai
    address public asset;
    // There is no minimum deposit amount (lets just pay gas)
    uint256 public amount;
    // Deposit recipient (my Address -> change to MANAGEMENTcontract)
    address public recipient;
    // 0 as default because no middle man
    uint16 public referralCode;

    constructor(IPoolAddressesProvider provider) {
        ADDRESSES_PROVIDER = provider;
        POOL = IPool(provider.getPool());

        /// Retrieve Pool address from mumbai
        // ADDRESSES_PROVIDER = IPoolAddressesProvider(
        //     address(0x5343b5bA672Ae99d627A1C87866b8E53F47Db2E6)
        // ); // Polygon mainnet address: 0xa97684ead0e402dC232d5A977953DF7ECBaB3CDb
        // POOL = IPool(ADDRESSES_PROVIDER.getPool()); // 8888888888888888888888888888888888888888888 maybe invalid sturcture?
        ADDRESS_WETH = address(0xA6FA4fB5f76172d178d61B04b0ecd319C5d1C0aa);

        owner = msg.sender;
        asset = ADDRESS_WETH;
        amount = 0.001 ether;
        recipient = address(this);
        // onBehalfOf = 0x434830d61c9a141614b2fDb6DC01481a9c366F7e;
        // referralCode = 0;
        // to = 0x434830d61c9a141614b2fDb6DC01481a9c366F7e;
    }

    function deposit() public payable onlyOwner {
        POOL.deposit(asset, amount, recipient, referralCode);
    }

    function withdraw() public payable onlyOwner {
        POOL.withdraw(asset, amount, recipient);
    }

    function deleteItAll() public onlyOwner {
        uint256 remainingWETH = IERC20(ADDRESS_WETH).balanceOf(address(this));
        IERC20(ADDRESS_WETH).transfer(msg.sender, remainingWETH);
        selfdestruct(payable(msg.sender));
    }

    modifier onlyOwner() {
        require(owner == msg.sender, "msg.sender must be the owner");
        _;
    }

    event Received(address, uint256);

    receive() external payable {
        emit Received(msg.sender, msg.value);
    }

    function helper() public view returns (address) {
        return address(POOL);
    }

    function helperTwo() public view returns (address) {
        return address(recipient);
    }
}
