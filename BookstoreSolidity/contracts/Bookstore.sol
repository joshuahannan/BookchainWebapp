pragma solidity ^0.4.11;

/**************************************************************************************
*
*   Contract:  Bookstore
*   
*   Description:  Contract that acts as a immutable public ledger for ebook transactions.
*   When a user creates an account, createUser is called from their address and their
*   address is added to the array of users in the system.  
*   When a user purchases a book, sendBooktoUser is called from their address, indicating
*   the book edition that was purchased and the public key of the specific copy.
*
*   Private Keys and their correstponding public keys are generated on the users 
*   device by an event triggered by the webapp after the purchase is confirmed.  The 
*   private key then stays on only the user's device.
*
*   This contract is not standards compatible and cannot be expected to talk to other
*   coin/token contracts. 
*
*   Possible changes:  
*   Better way to index books. right now we are just indexing them
*   with an integer that is created for the books in chronological order, but there
*   could be a better system.
*
*   Get rid of the removeUser function.  Removing a user might not be necessary since
*   it would cost more and we might still need to reference that information in the future.
*
*   Add more security checks for who is allowed to call functions.
*
*   Might need new types of events
*
*
***************************************************************************************/

contract Bookstore {   

    struct Book {
        uint32 editionID;                       // unique identifier for book
        uint256 pub_key;                        // public keys
    }

    struct User {                  
        uint32[] bookindices;                   // array of idices to each book the user owns
    }

    address public storeOwner;                         // owner of this bookstore (typically the bookseller)

    mapping ( address => User ) Users;          // this allows to look up Users by their ethereum address
    address[] public usersByAddress;                   // this is like a whitepages of all users, by ethereum address

    uint32 public totalBooks;                          // total number of books in the system
    mapping ( uint => Book ) Books;             // basically an array that maps indecies to Book structs.  is indexed by totalBooks

    // event showing transfer of book key
	event Transfer(uint32 editionID, address indexed _from, address indexed _to, uint256 public_key);

    event print(string message, address[] output);

	function Bookstore() payable {
	    storeOwner = msg.sender;                // make inital caller owner of all the copies   
        totalBooks = 0;                         // set the initial number of books in the system to 0
    }

    // Modifier for functions that are only allowed to be called by the bookstore owner
    modifier onlyOwner() {
        if (msg.sender != storeOwner) 
            throw;
        _;
    }

	// kills this contract (Can only be called by the bookstore owner)
    function kill() onlyOwner { suicide(storeOwner); }

    // when a new user registers on the website, their ethereum address is created and this function is called with it
    function createUser() {
        // don't overwrite existing entries
        if (userExists(msg.sender) == true) throw; 
        
        usersByAddress.push(msg.sender);           // adds an entry for this user to the user 'whitepages'
    }

    // function that checks if a certain user address exists
    function userExists(address eth_address) constant returns (bool success) {
        // iterate through the user white pages until you find a match
        for (uint i = 0; i < usersByAddress.length; i++) {
            if (eth_address == usersByAddress[i]) {
                return true;
            }
        }
    }

    // removes a user from the database, might not be necessary
    // TODO: remove books associated with user?
    function removeUser(address badUser) onlyOwner returns (bool success) {
        bool found = false;
        // searches through the user white pages for the user
        for (uint i = 0; i < (usersByAddress.length-1); i++) {
            if ( badUser == usersByAddress[i] ) {
                found = true;
            }
            // If the user was found, adjust the array so that it is a continuous list of active users
            if ( (found) && (userExists(usersByAddress[i+1])) ) {
                usersByAddress[i] = usersByAddress[i+1];
                if ( i == usersByAddress.length-2 ) {
                    //set the last element to 0 and delete the mapping for the User
                    usersByAddress[i+1] = 0;
                    delete Users[badUser];
                    return true;
                }
            }
        }
        return false;
    }

    // returns the owners Ethereum address
    function getOwner() constant returns (address) { return storeOwner; }

    // returns the array of all the User addresses
    function getUsers() constant returns (address[]) { return usersByAddress; }

    // returns a specific user by their address and returns the list of book indices that they own
    function getUser(address userAddress) constant returns (uint32[]) {
        //require(userExists(userAddress));  // NEED TO FIGURE THIS OUT 
        
        return (Users[userAddress].bookindices);
    }

    // returns editionID and public_key of a book copy from its index number
    function getBook(uint32 bookindex) constant returns (uint32, uint256) {
        return (Books[bookindex].editionID, Books[bookindex].pub_key);
    }

	// function for purchasing book
	// creates a new book struct and adds it's index to the User's array, then triggers Transfer event
	function sendBooktoUser(uint32 edition, uint256 key) {
        // make sure this user has created an account first
        if (!userExists(msg.sender)) throw;                                   

        address thisNewAddress = msg.sender;
        
        // create a new Book struct for the purchased book and populate its fields
        Books[totalBooks] = Book(edition,key);                
            
        // add the new Book struct index to the user's Bookindexes array and increment their ownership counter
        Users[thisNewAddress].bookindices.push(totalBooks);                   

        // increment the total numbero of books in the system
        totalBooks++;                                           

        // trigger event to send Elock file
        Transfer(edition,storeOwner,thisNewAddress,key); 

	}
    
}
