var Bookstore = artifacts.require("Bookstore.sol");

module.exports = function(deployer) {
  deployer.deploy(Bookstore);
};
