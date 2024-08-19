// Import necessary libraries from Hardhat
const hre = require("hardhat");

async function main() {
  // Compile contracts if they haven't been compiled yet
  await hre.run('compile');

  // Deploy Library contracts first, if needed
  const RLPWriter = await hre.ethers.getContractFactory("Lib_RLPWriter");
  const rlpWriter = await RLPWriter.deploy();
  await rlpWriter.deployed();
  console.log("Lib_RLPWriter deployed to:", rlpWriter.address);

  // Deploy other libraries similarly
  const SignTypes = await hre.ethers.getContractFactory("SignTypes");
  const signTypes = await SignTypes.deploy();
  await signTypes.deployed();
  console.log("SignTypes deployed to:", signTypes.address);

  // Deploy MigrationContract
  const MigrationContract = await hre.ethers.getContractFactory("MigrationContract");
  const migrationContract = await MigrationContract.deploy();
  await migrationContract.deployed();
  console.log("MigrationContract deployed to:", migrationContract.address);

  // Deploy Wallet contracts
  const ZrWallet = await hre.ethers.getContractFactory("ZrWallet");
  const zrWallet = await ZrWallet.deploy();
  await zrWallet.deployed();
  console.log("ZrWallet deployed to:", zrWallet.address);

  const ZrWalletManager = await hre.ethers.getContractFactory("ZrWalletManager");
  const zrWalletManager = await ZrWalletManager.deploy();
  await zrWalletManager.deployed();
  console.log("ZrWalletManager deployed to:", zrWalletManager.address);

  // Deploy Transaction contracts
  const ZrTransactionManager = await hre.ethers.getContractFactory("ZrTransactionManager");
  const zrTransactionManager = await ZrTransactionManager.deploy();
  await zrTransactionManager.deployed();
  console.log("ZrTransactionManager deployed to:", zrTransactionManager.address);

  const ZrTransaction = await hre.ethers.getContractFactory("ZrTransaction");
  const zrTransaction = await ZrTransaction.deploy();
  await zrTransaction.deployed();
  console.log("ZrTransaction deployed to:", zrTransaction.address);

  // Deploy Utility contracts
  const GasManager = await hre.ethers.getContractFactory("GasManager");
  const gasManager = await GasManager.deploy();
  await gasManager.deployed();
  console.log("GasManager deployed to:", gasManager.address);

  // Deploy the main contract (ZrSignTransfer)
  const ZrSignTransfer = await hre.ethers.getContractFactory("ZrSignTransfer");
  const zrSignTransfer = await ZrSignTransfer.deploy();
  await zrSignTransfer.deployed();
  console.log("ZrSignTransfer deployed to:", zrSignTransfer.address);

  // You can add more contract deployments as needed
}

main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });
