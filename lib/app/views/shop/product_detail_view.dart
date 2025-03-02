import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nop_commerce/app/controllers/home_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:nop_commerce/app/utils/color_helper.dart';
import 'package:nop_commerce/app/utils/extensions.dart';

class ProductDetailView extends StatelessWidget {
  ProductDetailView({super.key});

  final HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_productImage(), 20.SpaceX, _productDetails()],
        ),
      )),
    );
  }

  Widget _productImage() {
    return CarouselSlider(
      carouselController: homeController.productImageController,
      options: CarouselOptions(
        height: Get.height * .55,
        viewportFraction: 1,
        autoPlayAnimationDuration: const Duration(milliseconds: 1500),
        autoPlayInterval: const Duration(seconds: 7),
        onPageChanged: (index, _) {},
        // enlargeCenterPage: true,
        autoPlay: true,
      ),
      items: homeController.selectedProduct.value.images?.map((i) {
        return SlideInRight(
          child: Container(
            height: Get.height * .55,
            decoration: const BoxDecoration(),
            child: CachedNetworkImage(
              imageUrl: i.src ?? "",
              fit: BoxFit.cover,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(
                  color: ColorHelper.blueColor,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _productDetails() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                  text:
                      "${homeController.selectedProduct.value.price?.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                )
              ])),
          6.SpaceX,
          Text(
            (homeController.selectedProduct.value.name ?? "").capitalizeFirst ??
                "",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          3.SpaceX,
          const Divider(),
          3.SpaceX,
          Text(
            homeController.selectedProduct.value.fullDescription ?? "",
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
          ),
          3.SpaceX,
          // Text(
          //   homeController.selectedProduct.value.manufacturerIds?[0].toString() ?? "",
          //   style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
          // ),

        ],
      ),
    );
  }
}
