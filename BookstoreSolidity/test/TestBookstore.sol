pragma solidity ^0.4.2;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Bookstore.sol";

contract TestBookstore {
	address[] derp;

	function testNewUserCreated() {
		//Bookstore store = Bookstore(DeployedAddresses.Bookstore());

		//uint expected_length = 1;

		//derp.push(msg.sender);

		//Assert.isTrue(store.createUser(DeployedAddresses.Bookstore()),"User should have created successfully");

		//Assert.isTrue(store.userExists(DeployedAddresses.Bookstore()), "Created user badly");

		//Assert.lengthEqual(store.getUsers(),expected_length,"User array should be one element long"); 
	}

	/*function testgetUsers() {
		uint expected_length = 1;

		Assert.equal(store.getUsers().length,expected_length,"User array should be one element long");
	}*/
}
