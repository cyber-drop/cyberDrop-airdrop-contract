var contract = artifacts.require("./DistributeByTransferFrom.sol");

module.exports = function(deployer) {
  deployer.deploy(contract)
};
