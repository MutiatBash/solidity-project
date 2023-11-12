// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import "./huddleToken.sol";

contract tokenTransfer{

 address payable wallet;
 huddleToken public token;
 mapping(address => uint256) blockNumber;
 mapping(address => uint256) balances;

event Deposit(uint256 amount);
event Withdraw(uint256 amount);

constructor(address _tokenAddress){
    token = huddleToken(_tokenAddress);
}

receive() external payable{
emit Deposit(msg.value);
}

// function to deposit
function deposit(uint256 _amount) public payable  {
require(token.transferFrom(msg.sender, address(this), _amount), "Token deposit failed");
require(balances[msg.sender] >= _amount, "Insufficient funds");
require(address(this).balance > msg.value, "Insufficient funds");
balances[msg.sender] += _amount;
// blockNumber[msg.sender] = block.number + 70;
 }

 function withdraw(uint256 _amount) public {
 require(block.number >= blockNumber[msg.sender], "You cannot withdraw before the specified block number");
 require(balances[msg.sender] >= _amount, "Insufficient");
 uint256 balance = balances[msg.sender];
 
 require(token.transfer(msg.sender,balance),"Token withdrawal failed");
 balances[msg.sender] -= _amount;
 
 address payable _receiver = payable(msg.sender);
 (bool sent,) = _receiver.call{value:_amount}("");
 require(sent,"token not sent");
 }
}