// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity =0.7.6;
pragma abicoder v2;

import './interfaces/IStargateReceiver.sol';
import './TransferHelper.sol';

contract LockOn is IStargateReceiver {
    address public owner;
    address public receiver;

    constructor(address _receiver) {
        owner = _receiver;
        receiver = _receiver;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only onwer");
        _;
    }

    function setReceiver(address newReceiver) external onlyOwner {
        receiver = newReceiver;
    }

    /**
     * @param _srcChainId - source chain identifier
     * @param _srcAddress - source address identifier
     * @param _nonce - message ordering nonce
     * @param _token - token contract
     * @param _amountLD - amount (local decimals) to recieve
     * @param _payload - bytes containing the toAddress
     */
    function sgReceive(
        uint16 _srcChainId,
        bytes memory _srcAddress,
        uint256 _nonce,
        address _token,
        uint256 _amountLD,
        bytes memory _payload
    ) external override {
        TransferHelper.safeTransfer(_token, receiver, _amountLD);
    }
}