// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20 ;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract huddleToken is ERC20 {
    constructor()
        ERC20("HuddleToken", "HFK")
    {
        _mint(msg.sender, 100000 * 10 ** decimals());
    }

    function mint(address to, uint256 amount) public {
        _mint(to, amount);
    }
}