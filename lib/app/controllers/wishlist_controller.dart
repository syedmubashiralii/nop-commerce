import 'package:get/get.dart';
import 'package:nop_commerce/app/controllers/home_controller.dart';
import 'package:nop_commerce/app/models/cart_model.dart';
import 'package:nop_commerce/app/services/cart_services.dart';

class WishlistController extends GetxController {
  CartServices cartServices = CartServices();
  HomeController homeController = Get.put(HomeController());
  Rx<CartModel> wishlistModel = CartModel(shoppingCarts: []).obs;

  Future getWishListItems() async {
    wishlistModel.value = await cartServices.getWishListData().then((cartData) {
          List<ShoppingCarts> filteredCarts = cartData?.shoppingCarts
                  ?.where((cart) => cart.shoppingCartType == 'Wishlist')
                  .toList() ??
              [];

          return CartModel(shoppingCarts: filteredCarts);
        }) ??
        CartModel(shoppingCarts: []);
    print('wishlistModel  model: ${wishlistModel.value.toJson()}');
    wishlistModel.refresh();
    if (wishlistModel.value.shoppingCarts != null) {
      // shoppingCartCount.value =
      //     shoppingCartModel.value.shoppingCarts?.length ?? 0;
      wishlistModel.refresh();
    }
  }
}
