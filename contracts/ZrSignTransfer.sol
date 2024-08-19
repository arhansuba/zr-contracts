// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import "./libraries/SignTypes.sol";
import "./libraries/Lib_RLPWriter.sol";
import "./interfaces/IZRSign.sol";

contract ZrSignTransfer {

    IZrSign public zrSignConnect;
    uint256 private _nonce;
    uint256 private _gasPrice;
    uint256 private _gasLimit;
    bytes32 private constant EVMWalletType = "EVM_WALLET_TYPE";
    bytes32 private constant mumbaiChainId = "MUMBAI_CHAIN_ID";

    constructor(address _zrSignAddress) {
        zrSignConnect = IZrSign(_zrSignAddress);
    }

    function submitTransaction(
        uint256 _fromKeyIndex,
        address _to,
        uint _value,
        bytes memory _data
    ) public {
        bytes memory data = Lib_RLPWriter.writeBytes(_data);
        bytes memory rlpTransactionData = rlpEncodeTransaction(_nonce, _gasPrice, _gasLimit, _to, _value, data);
        
        SignTypes.ZrSignParams memory params = SignTypes.ZrSignParams({
            walletTypeId: EVMWalletType,
            walletIndex: _fromKeyIndex,
            dstChainId: mumbaiChainId,
            payload: rlpTransactionData,
            broadcast: true
        });

        zrSignConnect.zrSignTx(params);
        _nonce++;
    }

    function submitTransaction(
        uint256 fromKeyIndex,
        address to,
        uint256 value,
        uint256 gasPrice,
        uint256 gasLimit,
        uint256 nonce,
        bytes memory data
    ) public {
        bytes memory rlpPayloadData = Lib_RLPWriter.writeBytes(data);
        bytes memory rlpTransactionData = rlpEncodeTransaction(nonce, gasPrice, gasLimit, to, value, rlpPayloadData);
        
        SignTypes.ZrSignParams memory params = SignTypes.ZrSignParams({
            walletTypeId: EVMWalletType,
            walletIndex: fromKeyIndex,
            dstChainId: mumbaiChainId,
            payload: rlpTransactionData,
            broadcast: true
        });

        zrSignConnect.zrSignTx(params);
        _nonce++;
    }

    function submitTransaction(
        uint256 fromKeyIndex,
        address to,
        uint256 value,
        uint256 gasPrice,
        uint256 gasLimit,
        uint256 nonce,
        bytes memory data,
        bool broadcast
    ) public {
        bytes memory rlpPayloadData = Lib_RLPWriter.writeBytes(data);
        bytes memory rlpTransactionData = rlpEncodeTransaction(nonce, gasPrice, gasLimit, to, value, rlpPayloadData);
        
        SignTypes.ZrSignParams memory params = SignTypes.ZrSignParams({
            walletTypeId: EVMWalletType,
            walletIndex: fromKeyIndex,
            dstChainId: mumbaiChainId,
            payload: rlpTransactionData,
            broadcast: broadcast
        });

        zrSignConnect.zrSignTx(params);
        _nonce++;
    }

    function rlpEncodeTransaction(
        uint256 nonce,
        uint256 gasPrice,
        uint256 gasLimit,
        address to,
        uint256 value,
        bytes memory data
    ) internal pure returns (bytes memory) {
        bytes[] memory rlpEncoded = new bytes[](6);
        rlpEncoded[0] = Lib_RLPWriter.writeUint(nonce);
        rlpEncoded[1] = Lib_RLPWriter.writeUint(gasPrice);
        rlpEncoded[2] = Lib_RLPWriter.writeUint(gasLimit);
        rlpEncoded[3] = Lib_RLPWriter.writeAddress(to);
        rlpEncoded[4] = Lib_RLPWriter.writeUint(value);
        rlpEncoded[5] = data;
    
        return Lib_RLPWriter.writeList(rlpEncoded);
    }
}
