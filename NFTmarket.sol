// SPDX-License-Identifier: MIT
pragma solidity >=0.8.2 <0.9.0;

import "hardhat/console.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract NFTmarket is ReentrancyGuard{
    using Counters for Counters.Counter;
    Counters.Counter private _itemIds;
    Counters.Counter private _itemSold;

    address payable owner;
    uint256 listingPrice=0.025 ether;

    constructor(){
        owner=payable(msg.sender);
    }

    struct MarketItem{
        uint itemId;
        address nftContract;
        uint256 tokenId;
        address payable seller;
        address payable owner;
        uint256 price;
        bool sold;
    }

    mapping(uint256=>MarketItem) private IdToMarketItem;

    event MarketItemCreated(
        uint indexed itemId,
        address indexed nftContract,
        uint256 indexed tokenId,
        address  seller,
        address  owner,
        uint price,
        bool sold
 );

 function getListingPrice() public view returns(uint256){
     return listingPrice;
 }

 function createMarketItem(
     address nftContract,
     uint256 price,
     uint256 tokenId
 ) public payable nonReentrant{
     require(price> 0,"price must be atleast 1 wei");
     require(msg.value == listingPrice,"price must be equal to listing price");

    _itemIds.increment();

    uint256 itemId=_itemIds.current();
    IdToMarketItem[itemId]=MarketItem(
        itemId,
        nftContract,
        tokenId,
        payable(msg.sender),
        payable(address(0)),
        price,
        false
    );

    IERC721(nftContract).transferFrom(msg.sender,address(this),tokenId);

    emit MarketItemCreated(itemId, nftContract, tokenId, payable(msg.sender), payable(address(0)), price, false);
 }

 function createMarketSale(address nftContract,
 uint256 itemId) public payable nonReentrant{
    uint price  =IdToMarketItem[itemId].price;
    uint tokenId=IdToMarketItem[itemId].tokenId;

    require(msg.value==price,"please submit asking price in order to complete the puechase");

    IdToMarketItem[itemId].seller.transfer(msg.value);
    IERC721(nftContract).transferFrom(msg.sender,address(this),tokenId);
    IdToMarketItem[itemId].owner=payable(msg.sender);
    IdToMarketItem[itemId].sold=true;

    _itemSold.increment();
    payable(owner).transfer(listingPrice);
 }

 function fetchMarketItem() public view returns(MarketItem[] memory){
    uint itemCount= _itemIds.current();
    uint unsoldItemCount= _itemIds.current() - _itemSold.current();
    uint currentIndex=0;

    MarketItem[] memory items= new MarketItem[](unsoldItemCount);
    for(uint i=0;i<itemCount;i++){
        if(IdToMarketItem[i+1].owner==address(0))
        {
            uint currentId= IdToMarketItem[i+1].itemId;
            MarketItem storage currentItem=IdToMarketItem[currentId];
            items[currentIndex]=currentItem;
            currentIndex +=1;
        }
    }
    return items;
 }

 function fetchMyNFTs() public view returns(MarketItem[] memory){
     uint totalItemCount= _itemIds.current();
     uint itemCount=0;
     uint currentIndex=0;

     for(uint i=0;i<totalItemCount;i++){
         if(IdToMarketItem[i+1].owner==msg.sender){
             itemCount+=1;

         }
     }
     MarketItem[] memory items =new MarketItem[](itemCount);
      for(uint i=0;i<totalItemCount;i++){
        if(IdToMarketItem[i+1].owner==msg.sender)
        {
            uint currentId= IdToMarketItem[i+1].itemId;
            MarketItem storage currentItem=IdToMarketItem[currentId];
            items[currentIndex]=currentItem;
            currentIndex +=1;
        }
    }
    return items;
 }

 function fetchItemsCreated()public view returns(MarketItem[] memory){
     uint totalItemCount= _itemIds.current();
     uint itemCount=0;
     uint currentIndex=0;

     for(uint i=0;i<totalItemCount;i++){
         if(IdToMarketItem[i+1].seller==msg.sender){
             itemCount+=1;

         }
     }
     MarketItem[] memory items =new MarketItem[](itemCount);
      for(uint i=0;i<totalItemCount;i++){
        if(IdToMarketItem[i+1].seller==msg.sender)
        {
            uint currentId= IdToMarketItem[i+1].itemId;
            MarketItem storage currentItem=IdToMarketItem[currentId];
            items[currentIndex]=currentItem;
            currentIndex +=1;
        }
    }
    return items;
 }

    



}