pragma solidity 0.4.18;

import "./ERC677Receiver.sol";
import "./StandardToken.sol";

contract ERC677Token is StandardToken {
    function transferAndCall(address receiver, uint amount, bytes data) returns (bool success) {
        require(transfer(receiver, amount));
        return _postTransferCall(receiver, amount, data);
    }

    function _postTransferCall(address receiver, uint amount, bytes data) internal returns (bool success) {
        return ERC677Receiver(receiver).tokenFallback(msg.sender, amount, data);
    }
}
