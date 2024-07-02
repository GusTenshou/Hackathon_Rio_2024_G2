// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.20;

contract EnergyMarket {
    mapping(address => Vendor) public vendors;

    address owner;

    struct Vendor {                     
        uint saldo;
       // string place;
        uint tax;
        uint dailyCapacity; // Média
       // string name;
      //  uint power;
    }

    constructor() {
        owner = msg.sender;
    }


    function BuyEnergy(address vendor,) external payable {


        if( dailyCapacity > 0) {
            daily Capacity = dailyCapacity - x;
        }
    }

    function AddVendor() -> a {
        
    }

    function Withdraw() -> a {
        
    }

    function RemoveVendor() {
        
    }

}
