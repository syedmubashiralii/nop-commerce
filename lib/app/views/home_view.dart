import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nop_commerce/app/controllers/home_controller.dart';
import 'package:nop_commerce/app/utils/color_helper.dart';
import 'package:nop_commerce/app/views/shop/shop_view.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});

  final HomeController controller = Get.find();

// Screens
  final List<Widget> screens = [
    ShopView(),
    const Center(child: Text("Favorites")),
    const Center(child: Text("Orders")),
    const Center(child: Text("Cart")),
    const Center(child: Text("Profile")),
  ];

  // Icons
  final List<String> iconPaths = [
    'assets/icons/shop.png',
    'assets/icons/favorite.png',
    'assets/icons/categories.png',
    'assets/icons/cart.png',
    'assets/icons/profile.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: customBottomBar(),
      body: Obx(() => screens[controller.selectedIndex.value]),
    );
  }

  Obx customBottomBar() {
    return Obx(
      () => Container(
        height: 84,
        padding: EdgeInsets.symmetric(vertical: 14,horizontal: 24),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 1,
              spreadRadius: 0,
              offset: Offset(0, -1)
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(iconPaths.length, (index) {
            return GestureDetector(
              onTap: () => controller.changeIndex(index),
              child: Column(
                children: [
                  Image.asset(
                    iconPaths[index],
                    width: 22,
                    height: 22,
                    color: controller.selectedIndex.value == index
                        ? Colors.black
                        :  ColorHelper.blueColor
                  ),
                  if(controller.selectedIndex.value == index)
                  Container(
                    width: 9,
                    height: 2,
                    margin: EdgeInsets.only(top: 5),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(12)
                    ),
                  )
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
