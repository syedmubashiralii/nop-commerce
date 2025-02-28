import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nop_commerce/app/modules/home/controllers/auth_controller.dart';
import 'package:nop_commerce/app/modules/home/models/category_model.dart';
import 'package:nop_commerce/app/modules/home/models/product_model.dart';
import 'package:nop_commerce/app/modules/home/services/product_service.dart';
import 'package:nop_commerce/app/utils/constants.dart';

class HomeController extends GetxController {
  var currentPage = 0.obs;
  late PageController pageController; // Declare PageController

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

    pageController = PageController(); // Initialize it here
    fetchCategories();
    fetchProductList();
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

  // Catagories===============

  var categories = <Category>[].obs;
  var isLoading = false.obs;
  final Dio dio = Dio();
  final GetStorage storage = GetStorage();

  Future<void> fetchCategories() async {
    isLoading.value = true;

    // Retrieve token from storage
    String? token = storage.read('access_token');

    // If token is missing, wait for it to be retrieved
    if (token == null) {
      await requestNewToken();
      token = storage.read('access_token');

      if (token == null) {
        isLoading.value = false;
        return;
      }
    }

    try {
      final response = await dio.get(
        '$baseUrl/categories',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        var jsonData = response.data; // Ensure jsonData is a Map
        if (jsonData is Map && jsonData.containsKey('categories')) {
          List<dynamic> categoryList = jsonData['categories']; // Extract list
          List<Category> loadedCategories =
              categoryList.map((json) => Category.fromJson(json)).toList();
          categories.assignAll(loadedCategories);
        }
      }
    } catch (e) {
      print('Error fetching categories: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> requestNewToken() async {
    try {
      final response = await dio.post(
        'https://mobiledemo.herohero.store/token',
        data: {
          "guest": "true",
          "username": "",
          "password": "",
          "remember_me": "true",
        },
      );

      if (response.statusCode == 200) {
        String accessToken = response.data['access_token'];
        storage.write('access_token', accessToken);
      }
    } catch (e) {
      print('Error fetching new token: $e');
    }
  }

  // Products ================

  var productList = <Products>[].obs;

  final ProductService _apiService = ProductService();

  void fetchProductList() async {
    try {
      isLoading(true);
      ProductList? products = await _apiService.fetchProducts();
      if (products != null && products.products != null) {
        productList.assignAll(products.products!);
        print('Products fetched: ${productList.length}');
      }
    } finally {
      isLoading(false);
    }
  }

  // Top Products
  var topProducts = [
    'assets/images/bag.png',
    'assets/images/bag.png',
    'assets/images/bag.png',
    'assets/images/bag.png',
    'assets/images/bag.png',
  ].obs;
}
