const hre = require("hardhat");

async function main() {
  const AaveInteraction = await hre.ethers.getContractFactory(
    "AaveInteraction"
  );
  const lpAddressProviderAddress = "0x5343b5bA672Ae99d627A1C87866b8E53F47Db2E6"; // Polygon mainnet: 0xa97684ead0e402dC232d5A977953DF7ECBaB3CDb
  const aaveInteraction = await AaveInteraction.deploy(
    lpAddressProviderAddress
  );

  await aaveInteraction.deployed();
  console.log("AaveInteraction deployed to:", aaveInteraction.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });

// // Import the ABIs, see: https://docs.aave.com/developers/developing-on-aave/deployed-contract-instances
// import PoolAddressesProviderABI from "./PoolAddressesProvider.json"
// import PoolABI from "./Pool.json"

// // Retrieve the LendingPool address
//   //     address(0x5343b5bA672Ae99d627A1C87866b8E53F47Db2E6)
//         // ); // Polygon mainnet address: 0xa97684ead0e402dC232d5A977953DF7ECBaB3CDb
// const lpAddressProviderContract = new web3.eth.Contract(LendingPoolAddressesProviderABI, lpAddressProviderAddress)

// // Get the latest LendingPool contract address
// const lpAddress = await lpAddressProviderContract.methods
//     .getLendingPool()
//     .call()
//     .catch((e) => {
//         throw Error(`Error getting lendingPool address: ${e.message}`)
//     })
