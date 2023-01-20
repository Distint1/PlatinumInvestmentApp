// SPDX-License-Identifier: MIT

pragma solidity ^0.8.8;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

//Library cant send Ether, all funcions needs to be internal

library PriceConverter {
    //This next line of code is to convert to the ETH to USd and also to call the API into this contract.

    function getPrice(AggregatorV3Interface priceFeed) internal view returns (uint256) {
        // There are two things we need and are listed below to communicate with the call contract.
        //ABI
        //Address 0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e
        // AggregatorV3Interface priceFeed = AggregatorV3Interface(
        //     0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e
        
        //(uint80 roundId, int price, uint startedAt, uint timestamp, uint80 answeredInRound) = priceFeed.latestRoundData
        (, int256 price, , , ) = priceFeed.latestRoundData();
        // ETH in terms of USD
        // 3000.000000
        return uint256(price * 1e10); //1**10 == 10000000000
    }

    function getVersion() internal view returns (uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(
            0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e
        );
        return priceFeed.version();
    }

    function getConversionRate(
        uint256 ethAmount, AggregatorV3Interface priceFeed
    ) internal view returns (uint256) {
        uint256 ethPrice = getPrice(priceFeed);
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18;
        return ethAmountInUsd;
    }
}

// What is reverting? Undo any action before, and send remaining gas back
