/*
 * NB: since truffle-hdwallet-provider 0.0.5 you must wrap HDWallet providers in a 
 * function when declaring them. Failure to do so will cause commands to hang. ex:
 * ```
 * mainnet: {
 *     provider: function() { 
 *       return new HDWalletProvider(mnemonic, 'https://mainnet.infura.io/<infura-key>') 
 *     },
 *     network_id: '1',
 *     gas: 4500000,
 *     gasPrice: 10000000000,
 *   },
 */

var mnemonic = "unfold agent relax chair suffer example nation scout few good course oven"
var HDWalletProvider = require("truffle-hdwallet-provider");

module.exports = {
  networks: {
     mainnet: {
       provider: function() { 
         return new HDWalletProvider(mnemonic, 'https://mainnet.infura.io/') 
       },
       network_id: '1',
       gas: 4500000,
       gasPrice: 20000000000,
    },
    ropsten: {
      provider: function() {
        return new HDWalletProvider(mnemonic, "https://ropsten.infura.io/");
      },
      network_id: '3',
       gas: 4500000,
       gasPrice: 1000000000,

    },
    kovan: {
      provider: function() {
        return new HDWalletProvider(mnemonic, "https://kovan.infura.io/");
      },
      network_id: '42',
      gasPrice: 1000000000
    }
  }
};
