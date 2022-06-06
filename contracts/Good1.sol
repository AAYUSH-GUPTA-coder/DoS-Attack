// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Good1 {
    address public currentWinner;
    uint256 public currentAuctionPrice;
    mapping(address => uint256) public balances;

    constructor() {
        currentWinner = msg.sender;
    }

    function setCurrentAuctionPrice() public payable {
        require(
            msg.value > currentAuctionPrice,
            "Need to pay more than the currentAuctionPrice"
        );
        // balance[addr1] += 5 means (balance of addr1 = 0+5= 5)
        // balance[addr1] += 10 means (balance of addr1 = 10+5= 15)
        balances[currentWinner] += currentAuctionPrice;
        currentAuctionPrice = msg.value;
        currentWinner = msg.sender;
    }

    function withdraw() public {
        require(msg.sender != currentWinner, "Current winner cannot withdraw");

        uint256 amount = balances[msg.sender];
        balances[msg.sender] = 0;

        (bool sent, ) = msg.sender.call{value: amount}("");
        require(sent, "Failed to send Ether");
    }
}
