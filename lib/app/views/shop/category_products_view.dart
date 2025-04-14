import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nop_commerce/app/controllers/home_controller.dart';
import 'package:nop_commerce/app/models/product_model.dart';
import 'package:nop_commerce/app/utils/color_helper.dart';
import 'package:nop_commerce/app/utils/extensions.dart';
import 'package:nop_commerce/app/utils/widgets/custom_bottom_bar.dart';
import 'package:nop_commerce/app/views/shop/product_detail_view.dart';

class CategoryProductsView extends StatelessWidget {
  CategoryProductsView({super.key});

  final HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomBar(controller: homeController),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_appBar(), 20.SpaceX, _allProducts()],
          ),
        ),
      )),
    );
  }

  Widget _appBar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              homeController.selectedCategory.value.name ?? "",
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  fontWeight: FontWeight.w700),
            ),
            Row(
              children: [
                InkWell(
                    onTap: () {},
                    child: const Icon(
                      Icons.filter_list,
                      color: Colors.black,
                    )),
                6.SpaceY,
                InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(
                      Icons.close,
                      color: Colors.black,
                    )),
              ],
            )
          ],
        ),
        Text(
          homeController.selectedSubCategory.value.name ?? "",
          style: const TextStyle(
              color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _allProducts() {
    return Obx(
      () => GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: homeController.categoryProductList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: Get.width > 600 ? 3 : 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 4,
          childAspectRatio: 0.75,
        ),
        itemBuilder: (context, index) {
          final products = homeController.categoryProductList.toList();
          final product = products[index];
          return _productCard(product);
        },
      ),
    );
  }

  Widget _productCard(Products product) {
    return InkWell(
      onTap: () {
        homeController.selectedProduct.value = product;
        Get.to(() => ProductDetailView());
      },
      child: ListView(
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
                  text: "${homeController.selectedCurrency}",
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
              ])),
          // 6.SpaceX,
          // Row(
          //   children: [
          //     InkWell(
          //       onTap: () {
          //         homeController.addToCart(product.id??0,product.toJson());
          //       },
          //       child: Container(
          //         height: 40,
          //         width: 128,
          //         alignment: Alignment.center,
          //         decoration: BoxDecoration(
          //             color: Colors.black,
          //             borderRadius: BorderRadius.circular(12)),
          //         child: const Text(
          //           'Add To Cart',
          //           textAlign: TextAlign.center,
          //           style: TextStyle(
          //               color: ColorHelper.white,
          //               fontSize: 16,
          //               fontWeight: FontWeight.w300),
          //         ),
          //       ),
          //     ),
          //     const Spacer(),
          //     Container(
          //       height: 40,
          //       width: 47,
          //       decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(12),
          //           color: const Color(0xffF9F9F9)),
          //       child: const Icon(CupertinoIcons.heart),
          //     ),
          //     3.SpaceY,
          //   ],
          // )
       
        ],
      ),
    );
  }
}
