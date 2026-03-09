// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract PauseModule {
    bool public paused;

    modifier whenNotPaused() {
        require(!paused, "paused");
        _;
    }

    function pause() external {
        paused = true;
    }

    function unpause() external {
        paused = false;
    }
}
