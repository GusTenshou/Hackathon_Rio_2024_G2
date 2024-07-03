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
        uint price;
    }

    constructor() {
        owner = msg.sender;
    }


    function BuyEnergy(address vendor, uint amount) external payable {

        if(vendor.dailyCapacity >= amount) {
            dailyCapacity = dailyCapacity - amount;
            price = amount * x // x é o preço do kW;
        }

        if(vendor.dailyCapacity < amount) {
            price = dailyCapacity * x;
            amount = amount - dailyCapacity;
            price = price + amount * tax * x;
        }

        require(msg.value >= price, "Insufficient funds sent");
        vend.saldo += price;
        vend.dailyCapacity = vend.dailyCapacity >= amount ? vend.dailyCapacity - amount : 0;

        if (msg.value > price) {
            payable(msg.sender).transfer(msg.value - price);
        }
    }

    function AddVendor() -> a {
        
    }

    function Withdraw() -> a {
        
    }

    function RemoveVendor() {
        
    }

}
