This is the skeleton for the eBook Bookstore contract.  Each instance of an Bookstore contract corresponds to a bookseller's online marketplace.  

When a bookseller starts the store, the books and Users structs are created.  The Blockchain serves as a public record of purchases made in the bookstore. cryptography and user/book metadata is stored/performed off chain.

When the web app is completed, the flow of events will look like this:

User account is created on the app -> user struct is created for that user on the blockchain

## When the user purchases a book:

1.  User's client app generates a private/public key pair and securely stores the private key locally.
2.  User calls the sendBooktoUser function with the editionID and public key of the purchased book, gleaned from the website
3.  The edition ID and key are stored on the blockchain and referenced by the User's struct to prove ownership
4.  The webapp backend is notified of the transaction and fetches the copy of the book from the database (hopefully distributed storage, IPFS, Swarm, etc.)
5.  The webapp encrypts the book copy with the public key and sends it to the buyer.


The only part of all this that has been completed is the smart contract. ;)



## Building and the frontend

1. First run `truffle compile`, then run `truffle migrate` to deploy the contracts onto your network of choice (default "development").
1. Then run `npm run dev` to build the app and serve it on http://localhost:8080

## Possible upgrades

* Use the webpack hotloader to sense when contracts or javascript have been recompiled and rebuild the application. Contributions welcome!

## Common Errors

* **Error: Can't resolve '../build/contracts/Edition.json'**

This means you haven't compiled or migrated your contracts yet. Run `truffle compile` and `truffle migrate` first.

Full error:

```
ERROR in ./app/main.js
Module not found: Error: Can't resolve '../build/contracts/Edition.json' in '/Users/tim/Documents/workspace/Consensys/test3/app'
 @ ./app/main.js 11:16-59
```
