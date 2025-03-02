import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nop_commerce/app/controllers/authentication_controller.dart';
import 'package:nop_commerce/app/models/category_model.dart';
import 'package:nop_commerce/app/models/product_model.dart';
import 'package:nop_commerce/app/models/token_model.dart';
import 'package:nop_commerce/app/services/category_service.dart';
import 'package:nop_commerce/app/services/product_service.dart';
import 'package:nop_commerce/app/utils/requests.dart';
import 'package:nop_commerce/app/views/shop/all_categories_view.dart';

class HomeController extends GetxController {
  var currentPage = 0.obs;
  late PageController pageController;

  var authenticationController = Get.find<AuthenticationController>();
  String get selectedCurrency => authenticationController.stores[0].currencies[0].currencyCode;

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
  var subcategories = <CategoryModel>[].obs;
  Rx<CategoryModel> selectedCategory = CategoryModel().obs;
  Rx<CategoryModel> selectedSubCategory = CategoryModel().obs;
  var relatedSubcategories = <CategoryModel>[].obs;

  final CategoryService _categoryService = CategoryService();

  void onSelectCategory(CategoryModel category,bool navigate) {
    relatedSubcategories = subcategories
        .where((sub) => sub.parentCategoryId == category.id)
        .toList()
        .obs;
    log("${category.name}${relatedSubcategories.toString()}");
    selectedCategory.value = category;
    if (relatedSubcategories.isNotEmpty&&navigate==true) {
      Get.to(AllCategoriesView());
    }
  }

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
        categories.assignAll(
            loadedCategories.where((p) => p.parentCategoryId == 0).toList());
        subcategories.assignAll(
            loadedCategories.where((p) => p.parentCategoryId != 0).toList());

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
