import 'package:get/get.dart';
import 'package:nop_commerce/app/controllers/home_controller.dart';
import 'package:nop_commerce/app/models/cart_model.dart';
import 'package:nop_commerce/app/services/cart_services.dart';

class WishlistController extends GetxController {
  CartServices cartServices = CartServices();
  HomeController homeController = Get.put(HomeController());
  Rx<CartModel> wishlistModel = CartModel(shoppingCarts: []).obs;


  @override
  onReady() {
    getWishListItems();
  }

  Future getWishListItems() async {
    wishlistModel.value = await cartServices.getWishListData().then((cartData) {
          List<ShoppingCarts> filteredCarts = cartData?.shoppingCarts
                  ?.where((cart) => cart.shoppingCartType == 'Wishlist')
                  .toList() ??
              [];

          return CartModel(shoppingCarts: filteredCarts);
        }) ??
        CartModel(shoppingCarts: []);
    print('wishlistModel length: ${wishlistModel.value.shoppingCarts?.length}');
    wishlistModel.refresh();
    if (wishlistModel.value.shoppingCarts != null) {
      wishlistModel.refresh();
    }
  }

  void removeFromWishList(int productId) async {
    await cartServices.removeProductFromCart(productId);
    getWishListItems();
  }

  // void addToWishList(int productId, Map product) async {
  //   await cartServices.addProductToCart(productId, product, null);
  //   getWishListItems();
  // }

  void moveToCart(int productId, int cartItemID) async {
    await cartServices.moveToCart(productId, cartItemID);
    getWishListItems();
  }
}
