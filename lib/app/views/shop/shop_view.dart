import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nop_commerce/app/controllers/home_controller.dart';
import 'package:nop_commerce/app/models/product_model.dart';
import 'package:nop_commerce/app/utils/color_helper.dart';
import 'package:nop_commerce/app/utils/extensions.dart';
import 'package:nop_commerce/app/views/shop/all_categories_view.dart';
import 'package:nop_commerce/app/views/shop/product_detail_view.dart';

class ShopView extends StatelessWidget {
  final HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _appBar(),
                19.SpaceX,
                _buildSlider(),
                20.SpaceX,
                _header('Categories', () => Get.to(AllCategoriesView())),
                10.SpaceX,
                _allCategories(),
                10.SpaceX,
                _header('All Items', () {}),
                10.SpaceX,
                _allItemsGrid()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _appBar() {
    return const Row(
      children: [
        Text(
          'Shop',
          style: TextStyle(
              color: Colors.black, fontSize: 28, fontWeight: FontWeight.w700),
        )
      ],
    );
  }

  Widget _buildSlider() {
    return Obx(() => Column(
          children: [
            Container(
              width: Get.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.amber,
              ),
              height: 130,
              child: PageView.builder(
                controller: controller.pageController,
                itemCount: 4,
                onPageChanged: (index) {
                  controller.currentPage.value = index;
                },
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/big_sale.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Big Sale',
                              style: TextStyle(
                                  fontSize: 29,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white)),
                          1.SpaceX,
                          const Text('Up to 50%',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white)),
                          29.SpaceX,
                          const Text('Happening Now',
                              style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white)),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            10.SpaceX,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: controller.currentPage.value == index ? 40 : 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: controller.currentPage.value == index
                        ? ColorHelper.blueColor
                        : ColorHelper.blueColor.withOpacity(.2),
                    borderRadius: BorderRadius.circular(5),
                  ),
                );
              }),
            ),
          ],
        ));
  }

  Widget _allCategories() {
    return Obx(
      () => GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          crossAxisSpacing: Get.width * 0.02,
          mainAxisSpacing: Get.height * 0.02,
          childAspectRatio: 0.8,
        ),
        itemCount: controller.categories.length > 10
            ? 10
            : controller.categories.length,
        itemBuilder: (context, index) {
          final category = controller.categories[index];
          return InkWell(
            onTap: () => controller.onSelectCategory(category, true),
            child: Column(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 5),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(.2),
                          blurRadius: 10,
                          spreadRadius: 2,
                          offset: const Offset(0, 5)),
                    ],
                  ),
                  child: ClipOval(
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/images/loading.gif',
                      image: category.image?.src ?? "",
                      fit: BoxFit.cover,
                      imageErrorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/images/placeholder.jpg',
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                ),
                9.SpaceX,
                Text(
                  category.name ?? "",
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _header(String title, VoidCallback onTap) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        TextButton(
          onPressed: onTap,
          child: const Text(
            "See All",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: ColorHelper.blueColor,
            ),
          ),
        )
      ],
    );
  }

  Widget _allItemsGrid() {
    return Obx(
      () => GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.productList
            .where((p) => p.showOnHomePage == true)
            .length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: Get.width > 600 ? 3 : 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 4,
          childAspectRatio: 0.8,
        ),
        itemBuilder: (context, index) {
          final products = controller.productList
              .where((p) => p.showOnHomePage == true)
              .toList();
          final product = products[index];
          return _productCard(product);
        },
      ),
    );
  }

  Widget _productCard(Products product) {
    return InkWell(
      onTap: () {
        controller.selectedProduct.value = product;
        Get.to(() => ProductDetailView());
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 181,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(9),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 0,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            padding: const EdgeInsets.all(5),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(6),
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(
                      product.images != null ? product.images!.first.src! : '',
                    ),
                    fit: BoxFit.cover,
                  )),
            ),
          ),
          6.SpaceX,
          Text(
            product.name ?? '',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
          1.SpaceX,
          RichText(
              text: TextSpan(
                  text: "${controller.selectedCurrency}",
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  children: [
                TextSpan(
                  text: "${product.price?.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                )
              ]))
        ],
      ),
    );
  }
}
