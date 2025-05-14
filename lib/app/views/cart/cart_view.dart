import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nop_commerce/app/controllers/cart_controller.dart';
import 'package:nop_commerce/app/controllers/home_controller.dart';
import 'package:nop_commerce/app/controllers/wishlist_controller.dart';
import 'package:nop_commerce/app/utils/color_helper.dart';
import 'package:nop_commerce/app/utils/extensions.dart';
import 'package:nop_commerce/app/utils/widgets/custom_button.dart';
import 'package:nop_commerce/app/views/cart/cart_item.dart';
import 'package:nop_commerce/app/views/cart/checkout_view.dart';
import 'package:nop_commerce/app/views/cart/widgets/shipping_address_widget.dart';
import 'package:nop_commerce/app/views/settings/shipping_address_view.dart';
import 'package:nop_commerce/app/views/settings/widgets/common_widgets.dart';
import 'package:nop_commerce/app/views/wishlist/widgets/wishlist_item.dart';

class CartView extends StatelessWidget {
  CartController controller = Get.put(CartController());
  WishlistController wishlistController = Get.put(WishlistController());
  @override
  Widget build(BuildContext context) {
    controller.getShoppingCart();
    return Scaffold(
      bottomNavigationBar: _buildCheckoutBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBarWidget(
                  mainAxisAlignment: MainAxisAlignment.start,
                  text: 'Cart',
                  widget: Container(
                    margin: const EdgeInsets.only(left: 7),
                    height: 30,
                    width: 30,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                        color: ColorHelper.lightContainer,
                        shape: BoxShape.circle),
                    child: Obx(() {
                      return Text(
                        controller.shoppingCartCount.value.toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 18),
                      );
                    }),
                  ),
                ),
                7.SpaceX,
                ShippingAddressWidget(
                  onEdit: () {
                    Get.to(() => ShippingAddressView());
                  },
                ),
                const SizedBox(height: 16),
                Obx(() {
                  return Column(
                    children: controller.shoppingCartModel.value.shoppingCarts
                            ?.map((cartItem) {
                          return CartItem(
                              index: controller
                                  .shoppingCartModel.value.shoppingCarts!
                                  .indexOf(cartItem),
                              cartItem: cartItem);
                        }).toList() ??
                        [],
                  );
                }),
                21.SpaceX,
                const Text(
                  'From Your Wishlist',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                ),
                16.SpaceX,
                Obx(() => (wishlistController
                                .wishlistModel.value.shoppingCarts?.length ??
                            0) ==
                        0
                    ? Center(child: const Text("No data in wishlist"))
                    : ListView.builder(
                        itemCount: wishlistController
                                .wishlistModel.value.shoppingCarts?.length ??
                            0,
                        shrinkWrap: true,
                        itemBuilder: (context, index) => WishlistItem(
                            index: index,
                            cartItem: wishlistController
                                .wishlistModel.value.shoppingCarts![index]),
                      )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCheckoutBar() {
    String selectedCurrency = Get.find<HomeController>().selectedCurrencySymbol;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: const BoxDecoration(
        color: Color(0xffF5F5F5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Obx(() {
            return Row(
              children: [
                const Text(
                  'Total: ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                ),
                Text(
                  "$selectedCurrency ",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w400),
                ),
                Text(
                  (controller.shoppingCartModel.value.shoppingCarts?.fold(
                              0.0,
                              (sum, cart) =>
                                  sum +
                                  ((cart.product?.price ?? 0) *
                                      (cart.quantity ?? 1))) ??
                          0.0)
                      .toStringAsFixed(2),
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w700),
                ),
              ],
            );
          }),
          SizedBox(
              height: 40,
              width: 128,
              child: Obx(() {
                int length =
                    controller.shoppingCartModel.value.shoppingCarts?.length ??
                        0;
                return CustomButton(
                  buttonColor: length > 0
                      ? ColorHelper.blueColor
                      : ColorHelper.hintColor,
                  buttonText: 'Checkout',
                  onTap: () {
                    if (length > 0) {
                      Get.to(() => CheckoutView());
                    }
                  },
                );
              })),
        ],
      ),
    );
  }
}
