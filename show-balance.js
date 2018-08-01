"use strict";
var Web3 = require('web3');

// Settings
var ETH_ADDRESS = process.env.ETH_ADDRESS || '';
var ETH_PROVIDER = process.env.ETH_PROVIDER || 'http://localhost:8545'

// Connect to ethereum node
var web3 = new Web3(new Web3.providers.HttpProvider(ETH_PROVIDER));

// Print the address
console.log('Address:', ETH_ADDRESS);

// Get balance
web3.eth.getBalance(ETH_ADDRESS, function (error, result) {
  if (!error) {
    // Convert from wei and print balance
    console.log('Ether:', web3.utils.fromWei(result,'ether'));
  } else {
    console.log("ERROR", error);
}}); 
