import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nop_commerce/app/controllers/wishlist_controller.dart';
import 'package:nop_commerce/app/services/recently_viewed_service.dart';
import 'package:nop_commerce/app/utils/color_helper.dart';
import 'package:nop_commerce/app/utils/extensions.dart';
import 'package:nop_commerce/app/views/settings/widgets/common_widgets.dart';
import 'package:nop_commerce/app/views/shop/product_detail_view.dart';
import 'package:nop_commerce/app/views/wishlist/recently_viewed_items_view.dart';
import 'package:nop_commerce/app/views/wishlist/widgets/wishlist_item.dart';

class WishlistView extends StatelessWidget {
  WishlistView({super.key});

  final WishlistController controller = Get.put(WishlistController());

  Future<void> _onRefresh() async {
    await controller.getWishListItems();
  }

  @override
  Widget build(BuildContext context) {
    controller.getWishListItems();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppBarWidget(
                text: 'Wishlist',
              ),
              7.SpaceX,
              recentlyViewed(),
              14.SpaceX,
              _recentlyViewedListiew(),
              20.SpaceX,
              Expanded(
                child: RefreshIndicator(
                  onRefresh: _onRefresh,
                  child: Obx(() =>
                      (controller.wishlistModel.value.shoppingCarts?.length ??
                                  0) ==
                              0
                          ? const Center(child: Text("No data in wishlist"))
                          : ListView.builder(
                              itemCount: controller.wishlistModel.value
                                      .shoppingCarts?.length ??
                                  0,
                              itemBuilder: (context, index) =>
                                  WishlistItem(index: index,
                                      cartItem: controller.wishlistModel.value
                                          .shoppingCarts![index]),
                            )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _recentlyViewedListiew() {
    final products = RecentlyViewedService.getRecentlyViewed();

    if (products.isEmpty) {
      return const Text("No recently viewed items.");
    }
    return SizedBox(
      height: 55,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: InkWell(
              onTap: () {
                controller.homeController.selectedProduct.value = product;
                Get.to(() => ProductDetailView());
              },
              child: Container(
                width: 55,
                height: 55,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 5,
                      offset: const Offset(0, 0),
                    ),
                  ],
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(
                      product.images?.first.src ??
                          'https://via.placeholder.com/150',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget recentlyViewed() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Recently viewed',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        InkWell(
          onTap: () {
            Get.to(() => RecentlyViewedItemsView());
          },
          child: const CircleAvatar(
            radius: 15,
            backgroundColor: ColorHelper.blueColor,
            child: Icon(
              Icons.arrow_forward_sharp,
              color: Colors.white,
              size: 20,
            ),
          ),
        )
      ],
    );
  }
}
