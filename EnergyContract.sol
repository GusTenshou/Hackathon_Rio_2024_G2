// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.20;

contract energyMarket {
    mapping (address => Vendor) public vendors;

    address owner;
    uint energyCost;
    struct Vendor {                     
        uint saldo;
        uint tax;
        uint dailyCapacity; // Média
        uint remainingCapacity;
    }

    constructor( uint _energyCost ) {
        energyCost = _energyCost;
        owner = msg.sender;
    }


    function buyEnergy(address vendor, uint amount) external payable {
        uint price;
        if(vendors[vendor].remainingCapacity >= amount) {
            vendors[vendor].remainingCapacity = vendors[vendor].remainingCapacity - amount;
            price = amount * energyCost;
            vendors[vendor].remainingCapacity -= amount;
        }
            else {
            price = vendors[vendor].remainingCapacity * energyCost;
            amount -= vendors[vendor].remainingCapacity;
            price += amount * vendors[vendor].tax * energyCost;
            vendors[vendor].remainingCapacity = 0;
        }

        require(msg.value >= price, "Insufficient funds sent");
        vendors[vendor].saldo += price;
    
    
        if (msg.value > price) { /* TROCO */
            payable(msg.sender).transfer(msg.value - price);
        }
    }

    function changeCapacity(address vendorAddress, uint newCapacity) public{
        require(msg.sender == vendorAddress, "Incorrect address");
        vendors[vendorAddress].dailyCapacity = newCapacity;
    }

    function addVendor ( address newVendor, uint newCapacity, uint newTax) public {
        require( msg.sender == owner, "You need to be the owner to do this" );
            vendors[newVendor].dailyCapacity = newCapacity;
            vendors[newVendor].tax = newTax;
            vendors[newVendor].remainingCapacity = newCapacity;
            vendors[newVendor].saldo = 0;
        
    }

    function Withdraw() public payable {
         payable(msg.sender).transfer(vendors[msg.sender].saldo);
    }

    function setEnergyCost(uint newEnergyCost) public {
        require(msg.sender == owner, "You need to be the owner to do this" );
        energyCost = newEnergyCost;
    }

    function setTax(address vendorAddress, uint newTax) public {
        require(msg.sender == vendorAddress, "Incorrect addres");
        vendors[vendorAddress].tax = newTax;
    }
}
