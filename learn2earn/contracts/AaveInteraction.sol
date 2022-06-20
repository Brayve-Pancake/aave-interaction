// SPDX-License-Identifier: Unlicensed
pragma solidity 0.8.10;

import "@aave/core-v3/contracts/interfaces/IPool.sol";
import "@aave/core-v3/contracts/interfaces/IPoolAddressesProvider.sol";

// Used for testing
// import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol"; 88888888888 are these the same thing??????
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "hardhat/console.sol";

contract AaveInteraction {
    // Create varialbes to store pool address
    IPoolAddressesProvider public immutable ADDRESSES_PROVIDER;
    IPool public immutable POOL;
    address public immutable ADDRESS_WETH;
    address public immutable ADDRESS_MATIC;

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
        ADDRESS_WETH = address(0xd575d4047f8c667E064a4ad433D04E25187F40BB);
        ADDRESS_MATIC = address(0x9c3C9283D3e44854697Cd22D3Faa240Cfb032889);
        // wrapped matic: 0x9c3C9283D3e44854697Cd22D3Faa240Cfb032889;
        // 0xd575d4047f8c667E064a4ad433D04E25187F40BB or Depricated:0xA6FA4fB5f76172d178d61B04b0ecd319C5d1C0aa

        owner = msg.sender;
        asset = ADDRESS_MATIC;
        amount = 0.001 ether;
        recipient = address(this);
        // onBehalfOf = 0x434830d61c9a141614b2fDb6DC01481a9c366F7e;
        // referralCode = 0;
        // to = 0x434830d61c9a141614b2fDb6DC01481a9c366F7e;
    }

    function deposit() public payable onlyOwner {
        POOL.supply(asset, amount, recipient, referralCode);
        // POOL.supplyWithPermit(asset, amount, recipient, referralCode, deadline, permitV, permitR, permitS);
    }

    function withdraw() public payable onlyOwner {
        POOL.withdraw(asset, amount, recipient);
    }

    function deleteItAll() public onlyOwner {
        uint256 remainingWrappedAsset = IERC20(asset).balanceOf(address(this));
        IERC20(asset).transfer(msg.sender, remainingWrappedAsset);
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

    function helperPOOL() public view returns (address) {
        return address(POOL);
    }

    function helperRECIPIENT() public view returns (address) {
        return address(recipient);
    }

    function helperWETHbalance() public view returns (uint256) {
        return IERC20(asset).balanceOf(address(this));
    }
}
