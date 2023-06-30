// https://eth-sepolia.g.alchemy.com/v2/poW824z7baY51XHHw5_9oqfNZo7Mcnav

require("@nomiclabs/hardhat-waffle");

module.exports = {
  solidity: "0.8.0",
  networks: {
    sepolia: {
      url: "https://eth-sepolia.g.alchemy.com/v2/poW824z7baY51XHHw5_9oqfNZo7Mcnav",
      accounts: [
        "dfa5e75b3dbcc8e3b928e5723dab7ce657c620cac73bd991dbd8268aaac55a18",
      ],
    },
  },
};
