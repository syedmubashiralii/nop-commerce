import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nop_commerce/app/modules/home/controllers/auth_controller.dart';

class HomeController extends GetxController {
  var currentPage = 0.obs;
  late PageController pageController; // Declare PageController

  var authController = Get.find<AuthController>();

  @override
  void onInit() {
    super.onInit();
    Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (currentPage.value < 3) {
        currentPage.value++;
      } else {
        currentPage.value = 0;
      }
      pageController.animateToPage(
        currentPage.value,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });

    pageController = PageController(); // Initialize it here
  }

  @override
  void onClose() {
    pageController.dispose(); // Dispose of it properly
    super.onClose();
  }

// Bottom Navigation
  var selectedIndex = 0.obs;

  void changeIndex(int index) {
    selectedIndex.value = index;
  }

  // Catagories
  final List<Map<String, dynamic>> categories = [
    {
      "title": "Clothing",
      "count": 109,
      "images": [
        "assets/images/category.png",
        "assets/images/category.png",
        "assets/images/category.png",
        "assets/images/category.png"
      ]
    },
    {
      "title": "Shoes",
      "count": 530,
      "images": [
        "assets/images/category.png",
        "assets/images/category.png",
        "assets/images/category.png",
        "assets/images/category.png"
      ]
    },
    {
      "title": "Bags",
      "count": 87,
      "images": [
        "assets/images/category.png",
        "assets/images/category.png",
        "assets/images/category.png",
        "assets/images/category.png"
      ]
    },
    {
      "title": "Lingerie",
      "count": 218,
      "images": [
        "assets/images/category.png",
        "assets/images/category.png",
        "assets/images/category.png",
        "assets/images/category.png"
      ]
    },
    {
      "title": "Watch",
      "count": 218,
      "images": [
        "assets/images/category.png",
        "assets/images/category.png",
        "assets/images/category.png",
        "assets/images/category.png"
      ]
    },
    {
      "title": "Hoodies",
      "count": 218,
      "images": [
        "assets/images/category.png",
        "assets/images/category.png",
        "assets/images/category.png",
        "assets/images/category.png"
      ]
    },
  ].obs;

  // Top Products
  var topProducts = [
    'assets/images/bag.png',
    'assets/images/bag.png',
    'assets/images/bag.png',
    'assets/images/bag.png',
    'assets/images/bag.png',
  ].obs;
}
