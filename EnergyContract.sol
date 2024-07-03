// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.20;

contract EnergyMarket {
    mapping (address => Vendor) public vendors;

    address owner;
    uint energyCost;
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


    function BuyEnergy(address vendor, uint amount) external payable {
        uint price;
        if(vendors[vendor].dailyCapacity >= amount) {
            vendors[vendor].dailyCapacity = vendors[vendor].dailyCapacity - amount;
            price = amount * energyCost; // x é o preço do kW
            vendors[vendor].dailyCapacity -= amount;
        }
            else {
            price = vendors[vendor].dailyCapacity * energyCost;
            amount -= vendors[vendor].dailyCapacity;
            price += amount * vendors[vendor].tax * energyCost;
            vendors[vendor].dailyCapacity = 0;
        }

        require(msg.value >= price, "Insufficient funds sent");
        vendors[vendor].saldo += price;
    
    
        if (msg.value > price) { /* TROCO */
            payable(msg.sender).transfer(msg.value - price);
        }
    }

    function AddVendor ( address newVendor, uint newCapacity, uint newTax) public {
        require( msg.sender == owner );
            vendors[newVendor].dailyCapacity = newCapacity;
            vendors[newVendor].dailyCapacity = newTax;
            vendors[newVendor].saldo = 0;
        
    }

    function Withdraw() public {
        
    }

    function RemoveVendor() public{
        
    }

}
