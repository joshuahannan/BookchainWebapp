# Bookchain Web App

# Bookchain
Super awesome world changing ebook thingamajig

A system for mediating transactions of eBooks in a secure fashion in order to provide proof of ownership and deter piracy

Read the draft of the white paper here: https://docs.google.com/document/d/1uqc68dUAwztsliJO7dsYvnpGNvCYWSkGL-XiyNOWVhY/pub

All other useful information and code for the smart contract and app is in the BookstoreSolidity/ directory

React Web app is in the BookstoreReactApp/ directory

Concept created and designed by Joshua Hannan, Cole Thrower, and David Kile

Smart Contracts designed by Joshua Hannan

Webapp created by Kevin Hannan and Joshua Hannan based off of https://github.com/Tectract/ethereum-demo-tools





###dependencies

(install nodejs and npm, latest versions if you can)

npm i -g ethereumjs-testrpc

npm i -g ethereumjs-util     # see note below

npm i -g truffle

truffle commands:

truffle init

truffle compile

truffle migrate

truffle console

### testrpc startup with pre-set seed phrase and pre-defined networkID

COMMAND FROM DEMO ARTICLE: testrpc -m "sample dog come year spray crawl learn general detect silver jelly pilot" --network-id 20


###app creation

this app was created with: create-react-app (see: https://github.com/facebookincubator/create-react-app)


to install the app locally

git clone https://www.github.com/joshuahannan/Bookchainapp/

cd Bookchainapp/BookchainReactApp

npm i

npm start 

(or) npm run build 

if testing against a localhost and local deployment of the contract, you'll have to update the contract address in App.js!

otherwise just use metamask plugin and connect to mainnet to test the app, even if running locally :)
