import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nop_commerce/app/controllers/home_controller.dart';
import 'package:nop_commerce/app/utils/color_helper.dart';
import 'package:nop_commerce/app/utils/widgets/custom_bottom_bar.dart';
import 'package:nop_commerce/app/views/cart/cart_view.dart';
import 'package:nop_commerce/app/views/settings/settings_view.dart';
import 'package:nop_commerce/app/views/shop/shop_view.dart';
import 'package:nop_commerce/app/views/wishlist/wishlist_view.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});

  final HomeController controller = Get.find();

// Screens
  final List<Widget> screens = [
    ShopView(),
    WishlistView(),
    const Center(child: Text("Orders")),
    CartView(),
    SettingsView(),
  ];

  // Icons
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: CustomBottomBar( controller: controller),
      body: Obx(() => screens[controller.selectedIndex.value]),
    );
  }
}

