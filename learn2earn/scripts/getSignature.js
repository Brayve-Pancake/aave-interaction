import { ethers } from "ethers";
// import { Pool } from "@aave/contract-helpers";
// const hre = require("hardhat");

async function main() {
  let provider = ethers.getDefaultProvider([
    "https://polygon-mumbai.g.alchemy.com/v2/gPoSuEJcXDwVB6W8ZWVtNMnlwsavoumo",
    [gPoSuEJcXDwVB6W8ZWVtNMnlwsavoumo],
  ]);
  console.log(provider);

  // const pool = new Pool(provider, {
  //   POOL: poolAddress,
  //   WETH_GATEWAY: wethGatewayAddress,
  // });

  // const dataToSign = await pool.signERC20Approval({
  //   user,
  //   reserve,
  //   amount,
  // });

  // const signature = await provider.send('eth_signTypedData_v4', [
  //   currentAccount,
  //   dataToSign,
  // ]);

  // // This signature can now be passed into the supplyWithPermit() function below

  // function submitTransaction({
  //   provider: providers.getDefaultProvider,
  //   tx: EthereumTransactionTypeExtended
  // }){
  //   const extendedTxData = await tx.tx();
  //   const { from, ...txData } = extendedTxData;
  //   const signer = provider.getSigner(from);
  //   const txResponse = await signer.sendTransaction({
  //     ...txData,
  //     value: txData.value ? BigNumber.from(txData.value) : undefined,
  //   });
  // }
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
