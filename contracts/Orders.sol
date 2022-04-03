pragma solidity ^0.5.0;

contract Orders {
  enum Status {Created, Paid, Delivered, Refunded}

  struct Order {
          string id;
          uint256 totalPrice;
          uint256 deliveryDate;
          Status status;
          uint256 createdDate;
          uint256 deliveredDate;
      }

  address owner;

  // to be able to store and query orders according to order id
  mapping(string => Order) orders;

  modifier onlyOwner {
          require(msg.sender == owner, "UNAUTHORIZED");
          _;
      }

  constructor() public {
          owner = msg.sender;
      }

  // receive order information, only contract owner should be able to call this function.
  function add(string memory id, uint256 totalPrice, uint256 deliveryDate) public onlyOwner {
          orders[id] = Order(id, totalPrice, deliveryDate, Status.Created, block.timestamp, 0);
      }

  function get(string memory id) public view returns (uint8 status, uint256 createdDate, uint256 deliveryDate,
  uint256 deliveredDate) {

          Order memory order = orders[id];
          require(order.createdDate > 0, "ORDER_NOT_FOUND");

        return (uint8(order.status), order.createdDate, order.deliveryDate, order.deliveredDate);
      }
}
