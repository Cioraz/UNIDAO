// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract deadManSwitch {
    address owner;
    address presetAddress;
    uint lastActiveBlock;
    
    constructor(address _presetAddress) {
        owner = msg.sender;
        presetAddress = _presetAddress;
        lastActiveBlock = block.number;
    }
    
    function still_alive() public {
        require(msg.sender == owner);
        lastActiveBlock = block.number;
    }
    
    function Alive() public view returns (bool) {
        if(block.number - lastActiveBlock <= 10) return true;
        else return false;
    }
    
    function transferFunds() public {
        require(!Alive());
        uint contractBalance = address(this).balance;
        payable(presetAddress).transfer(contractBalance); 
    }
}
