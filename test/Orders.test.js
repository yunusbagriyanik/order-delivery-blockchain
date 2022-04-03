const Orders = artifacts.require("Orders");

contract('Orders', (accounts) => {

  before(async () => {
    const instance = await Orders.deployed();
  });

  describe('Create Order', () => {

    const orderId = '1000';
    const totalPrice = web3.utils.toWei('4.5', 'ether');

    const date = new Date();
    date.setMonth(date.getMonth() + 1);
    const deliveryDate = Math.round(date.getTime() / 1000);

    it('Sender is not authorized!', () => {
      return Orders.deployed().then((instance) => {

        return instance.add(orderId, totalPrice, deliveryDate, {
          from: accounts[1]
        });
      }).then(assert.error).catch((error) => {
        console.log("accounts[1]")
      });
    })

    it('Created Order!', async () => {
      const instance = await Orders.deployed();
      await instance.add(orderId, totalPrice, deliveryDate);
      let order = await instance.get(orderId);

      assert.equal(order.status, 0, "Order status doesn't match Created");
    })


  });
});
