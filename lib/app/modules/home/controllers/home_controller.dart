import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nop_commerce/app/modules/home/controllers/authentication_controller.dart';
import 'package:nop_commerce/app/modules/home/models/category_model.dart';
import 'package:nop_commerce/app/modules/home/models/product_model.dart';
import 'package:nop_commerce/app/modules/home/models/token_model.dart';
import 'package:nop_commerce/app/modules/home/services/category_service.dart';
import 'package:nop_commerce/app/modules/home/services/product_service.dart';
import 'package:nop_commerce/app/utils/constants.dart';
import 'package:nop_commerce/app/utils/requests.dart';

class HomeController extends GetxController {
  var currentPage = 0.obs;
  late PageController pageController;

  var authenticationController = Get.find<AuthenticationController>();

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

    pageController = PageController();
    fetchCategories();
    fetchProductList();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  var selectedIndex = 0.obs;

  void changeIndex(int index) {
    selectedIndex.value = index;
  }

//Categories

  var categories = <CategoryModel>[].obs;

  final CategoryService _categoryService = CategoryService();

  Future<void> fetchCategories() async {
    String? token = Requests.box.read('access_token');
    if (token == null) {
      authenticationController.authModel.value =
          await Requests.requestNewToken() ?? TokenModel();
      authenticationController.accessToken.value =
          authenticationController.authModel.value.accessToken ?? "";
      authenticationController.customerGuid.value =
          authenticationController.authModel.value.customerGuid ?? "";
    }
    try {
      var categoriesData = await _categoryService.getCategories();
      if (categoriesData is List) {
        List<CategoryModel> loadedCategories = categoriesData
            .map((json) => CategoryModel.fromJson(json as Map<String, dynamic>))
            .toList();
        categories.assignAll(loadedCategories);
        categories.refresh();
      } else {
        print("Invalid categories data format");
      }
    } catch (e) {
      print('Error fetching categories: $e');
    }
  }

  // Products ================

  var productList = <Products>[].obs;

  final ProductService _productsService = ProductService();

  void fetchProductList() async {
    try {
      ProductList? products = await _productsService.fetchProducts();
      if (products != null && products.products != null) {
        productList.assignAll(products.products!);
        productList.refresh();
        print('Products fetched: ${productList.length}');
      }
    } catch (e) {
      print(e.toString());
    } finally {}
  }
}
