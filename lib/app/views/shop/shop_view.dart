import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nop_commerce/app/controllers/home_controller.dart';
import 'package:nop_commerce/app/models/product_model.dart';
import 'package:nop_commerce/app/utils/color_helper.dart';
import 'package:nop_commerce/app/utils/extensions.dart';
import 'package:nop_commerce/app/views/shop/all_categories_view.dart';
import 'package:nop_commerce/app/views/shop/product_detail_view.dart';
import 'package:nop_commerce/app/views/shop/see_all_products_view.dart';
import 'package:nop_commerce/app/views/shop/widgets/product_card.dart';

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
                Obx(() {
                  return _header('All Items', () {
                    Get.to(SeeAllProductsView());
                  },
                      showSeeAll: controller.productList
                              .where((p) => p.showOnHomePage == true)
                              .length >
                          6);
                }),
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
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 130,
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 1,
            onPageChanged: (index, reason) {
              controller.currentPage.value = index;
            },
          ),
          items: List.generate(4, (index) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.amber,
                image: const DecorationImage(
                  image: AssetImage('assets/images/big_sale.png'),
                  fit: BoxFit.cover,
                ),
              ),
              width: Get.width,
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Big Sale',
                        style: TextStyle(
                            fontSize: 29,
                            fontWeight: FontWeight.w700,
                            color: Colors.white)),
                    SizedBox(height: 4),
                    Text('Up to 50%',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Colors.white)),
                    SizedBox(height: 4),
                    Text('Happening Now',
                        style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: Colors.white)),
                  ],
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(4, (index) {
            return Obx(() => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: controller.currentPage.value == index ? 40 : 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: controller.currentPage.value == index
                        ? ColorHelper.blueColor
                        : ColorHelper.blueColor.withOpacity(.2),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ));
          }),
        ),
      ],
    );
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

  Widget _header(String title, VoidCallback onTap, {bool showSeeAll = true}) {
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
        if (showSeeAll)
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
                    .length >
                6
            ? 6
            : controller.productList
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
          return ProductCard(
            product: product,
          );
        },
      ),
    );
  }
}
