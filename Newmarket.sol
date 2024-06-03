// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

contract SupplyChain {
    struct Product {
        uint256 productId;
        string productName;
        address owner;
        uint256 price;
        bool available;
    }

    mapping(uint256 => Product) public products;
    uint256 public productCounter;

    event ProductAdded(uint256 indexed productId, string productName, address indexed owner, uint256 price);
    event ProductPurchased(uint256 indexed productId, address indexed buyer);

    function addProduct(string memory _productName, uint256 _price) public {
        productCounter++;
        products[productCounter] = Product(productCounter, _productName, msg.sender, _price, true);
        emit ProductAdded(productCounter, _productName, msg.sender, _price);
    }

    function purchaseProduct(uint256 _productId) public payable {
        Product storage product = products[_productId];
        require(product.available, "Product is not available");
        require(msg.value == product.price, "Invalid amount sent");

        product.available = false;
        emit ProductPurchased(_productId, msg.sender);

        // Transfering the funds to the product owner
        payable(product.owner).transfer(msg.value);
    }

    function getProduct(uint256 _productId) public view returns (uint256, string memory, address, uint256, bool) {
        Product storage product = products[_productId];
        return (product.productId, product.productName, product.owner, product.price, product.available);
    }
}
