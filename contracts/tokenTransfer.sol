// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./huddleToken.sol";

contract tokenTransfer{

 address payable wallet;
 address public owner;
 huddleToken public token;
 mapping(address => uint256) blockNumber;
 mapping(address => uint256) balances;

event Deposit(uint256 amount);
event Withdraw(uint256 amount);

constructor(){
    token = huddleToken(0x7BF41f6a1Eb6b909Fc32417D5Da2Be89162F31Eb);
    owner = msg.sender;
}

receive() external payable{

}

// function to deposit
function deposit(uint _amount) public  {
require(balances[msg.sender] >= _amount, "Insufficient funds");

// require(token.transferFrom(msg.sender, address(this), _amount), "try again");
token.transferFrom(msg.sender, address(this), _amount);
balances[msg.sender] = balances[msg.sender] + _amount;
// emit Deposit(_amount);
blockNumber[msg.sender] = block.number + 70;
 }

 function withdraw(uint _amount) public {
 require(block.number >= blockNumber[msg.sender], "You cannot withdraw before the specified block number");
 require(balances[msg.sender] >= _amount, "Insufficient");
 uint256 balance = balances[msg.sender];
 
// To check the balance
require(balance >= _amount, "Insufficient funds, unable to withdraw");

 token.transfer(msg.sender,_amount);
 balances[msg.sender] -= _amount;
//  emit Withdraw(_amount);

// balances[msg.sender] = 0;
 
//  address payable _receiver = payable(msg.sender);
//  (bool sent,) = _receiver.call{value:_amount}("");
//  require(sent,"token not sent");
 }
}