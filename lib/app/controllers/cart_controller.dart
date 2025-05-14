import 'package:get/get.dart';
import 'package:nop_commerce/app/models/cart_model.dart';
import 'package:nop_commerce/app/services/cart_services.dart';
import 'package:nop_commerce/app/services/order_services.dart';

class CartController extends GetxController {
  RxString selectedShippingMethod = 'Standard'.obs;
  CartServices cartServices = CartServices();
  Rx<CartModel> shoppingCartModel = CartModel(shoppingCarts: []).obs;
  RxInt shoppingCartCount = 0.obs;
  OrderServices orderServices = OrderServices();

  @override
  onReady() {
    // getShoppingCart();
  }

  RxList shippingOptions = [
    {'name': 'Standard', 'deliveryTime': '5-7 days', 'price': 'FREE'},
    {'name': 'Express', 'deliveryTime': '1-2 days', 'price': '\$12,00'}
  ].obs;

  void getShoppingCart() async {
    shoppingCartModel.value =
        await cartServices.getShoppingCart().then((cartData) {
              List<ShoppingCarts> filteredCarts = cartData?.shoppingCarts
                      ?.where((cart) => cart.shoppingCartType == 'ShoppingCart')
                      .toList() ??
                  [];

              return CartModel(shoppingCarts: filteredCarts);
            }) ??
            CartModel(shoppingCarts: []);
    print(
        'shopping cart model length: ${shoppingCartModel.value.shoppingCarts?.length}');
    shoppingCartModel.refresh();
    if (shoppingCartModel.value.shoppingCarts != null) {
      shoppingCartCount.value =
          shoppingCartModel.value.shoppingCarts?.length ?? 0;
      shoppingCartCount.refresh();
    }
  }

  void updateProductQuantity(int id, int productId, int quantity) async {
    await cartServices.updateProductQuantity(id, productId, quantity);
    getShoppingCart();
  }

  // void addToCart(int productId, Map product) async {
  //   await cartServices.addProductToCart(productId, product, null);
  //   getShoppingCart();
  // }

  Future<void> createOrder() async {
    var response = await orderServices.createOrder(
        shoppingCartModel.value.shoppingCarts
            ?.map((va) => va.toJson())
            .toList(),
        0);
  }

  void removeFromCart(int productId) async {
    await cartServices.removeProductFromCart(productId);
    getShoppingCart();
  }

  void updateShippingMethod(String method) {
    selectedShippingMethod.value = method;
  }

  void updateShippingOptions(int index) {
    selectedShippingMethod.value = shippingOptions[index]['name'];
  }

  void updateShippingAddress(String address) {
    // Update the shipping address logic here
  }
  void updatePaymentMethod(String method) {
    // Update the payment method logic here
  }
  void updatePaymentOptions(int index) {
    // Update the payment options logic here
  }
}
