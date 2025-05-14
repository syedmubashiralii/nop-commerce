import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nop_commerce/app/controllers/home_controller.dart';
import 'package:nop_commerce/app/controllers/wishlist_controller.dart';
import 'package:nop_commerce/app/models/cart_model.dart';
import 'package:nop_commerce/app/utils/color_helper.dart';

class WishlistItem extends StatelessWidget {
  final int index;
  final ShoppingCarts cartItem;

  const WishlistItem({super.key, required this.index, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<WishlistController>();
    String selectedCurrency = Get.find<HomeController>().selectedCurrencySymbol;
    final product = cartItem.product;

    return Container(
      height: 120,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 3),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 6,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: product?.images?.isNotEmpty ?? false
                      ? Image.network(
                          product?.images?[0].src ?? "",
                          width: 105,
                          height: 105,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          "assets/images/bag.png",
                          width: 105,
                          height: 105,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              Positioned(
                bottom: 7,
                left: 7,
                child: InkWell(
                  onTap: () {
                    controller.removeFromWishList(
                      cartItem.productId ?? 0,
                    );
                  },
                  child: const CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 17,
                    child: Icon(
                      CupertinoIcons.delete,
                      color: ColorHelper.lightPink,
                      size: 18,
                    ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  product?.name ?? "Product Name",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const Spacer(),
                Text(
                  product?.shortDescription ?? "No Description",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (cartItem.product?.oldPrice != null &&
                        cartItem.product!.oldPrice != 0.0) ...[
                      Row(
                        children: [
                          Text("${selectedCurrency}",
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  decoration: TextDecoration.lineThrough,
                                  decorationColor: ColorHelper.lightRed,
                                  color: ColorHelper.lightRed)),
                          Text("${cartItem.product!.oldPrice}",
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.lineThrough,
                                  decorationColor: ColorHelper.lightRed,
                                  color: ColorHelper.lightRed)),
                        ],
                      ),
                      const SizedBox(width: 4),
                      Row(
                        children: [
                          Text("${selectedCurrency} ",
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w400)),
                          Text("${cartItem.product?.price ?? ""}",
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w700)),
                        ],
                      ),
                    ] else
                      Row(
                        children: [
                          Text("${selectedCurrency} ",
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w400)),
                          Text("${cartItem.product?.price ?? 0}",
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w700)),
                        ],
                      ),
                    // Row(
                    //   children: [
                    //     _plusMinusButton(CupertinoIcons.minus, () {
                    //       final minQuantity =
                    //           cartItem.product?.orderMinimumQuantity ?? 0;
                    //       final currentQuantity = cartItem.quantity ?? 0;
                    //       final productId = cartItem.productId ?? 0;
                    //       final cartItemId = cartItem.id ?? 0;
                    //       final shoppingCarts =
                    //           controller.shoppingCartModel.value.shoppingCarts;
                    //       if (currentQuantity <= 1) {
                    //         controller.removeFromCart(cartItemId);
                    //         return;
                    //       }
                    //       if (currentQuantity <= minQuantity) {
                    //         Get.snackbar("Error",
                    //             "You cannot order less than $minQuantity items");
                    //         return;
                    //       }
                    //       final newQuantity = currentQuantity - 1;
                    //       shoppingCarts![index].quantity = newQuantity;
                    //       controller.shoppingCartModel.refresh();
                    //       controller.updateProductQuantity(
                    //         cartItemId,
                    //         productId,
                    //         newQuantity,
                    //       );
                    //     }),
                    //     Container(
                    //       margin: const EdgeInsets.symmetric(horizontal: 6),
                    //       padding: const EdgeInsets.symmetric(
                    //           horizontal: 10, vertical: 4),
                    //       decoration: BoxDecoration(
                    //         color: const Color(0xffE5EBFC),
                    //         borderRadius: BorderRadius.circular(4),
                    //       ),
                    //       child: Text('${cartItem.quantity ?? 0}',
                    //           style: const TextStyle(
                    //               fontSize: 14, fontWeight: FontWeight.w500)),
                    //     ),
                    //     _plusMinusButton(CupertinoIcons.add, () {
                    //       final maxQuantity =
                    //           cartItem.product?.orderMaximumQuantity ?? 0;
                    //       final currentQuantity = cartItem.quantity ?? 0;
                    //       final productId = cartItem.productId ?? 0;
                    //       final cartItemId = cartItem.id ?? 0;
                    //       final shoppingCarts =
                    //           controller.shoppingCartModel.value.shoppingCarts;
                    //       if (currentQuantity >= maxQuantity) {
                    //         Get.snackbar(
                    //           "Error",
                    //           "You cannot add more than $maxQuantity items",
                    //         );
                    //         return;
                    //       }
                    //       final newQuantity = currentQuantity + 1;
                    //       shoppingCarts![index].quantity = newQuantity;
                    //       controller.shoppingCartModel.refresh();
                    //       controller.updateProductQuantity(
                    //         cartItemId,
                    //         productId,
                    //         newQuantity,
                    //       );
                    //     })
                    //   ],
                    // )
                
                     IconButton(icon: SvgPicture.asset('assets/images/add-to-cart.svg'),
                      onPressed: () {
                        Get.find<WishlistController>().moveToCart(cartItem.productId??0,cartItem.id??0);
                      }),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

 
}
