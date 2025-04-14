import 'dart:async';
import 'dart:developer';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nop_commerce/app/controllers/authentication_controller.dart';
import 'package:nop_commerce/app/models/category_model.dart';
import 'package:nop_commerce/app/models/product_model.dart';
import 'package:nop_commerce/app/models/token_model.dart';
import 'package:nop_commerce/app/routes/app_pages.dart';
import 'package:nop_commerce/app/services/cart_services.dart';
import 'package:nop_commerce/app/services/category_service.dart';
import 'package:nop_commerce/app/services/product_service.dart';
import 'package:nop_commerce/app/utils/custom_flash_widget.dart';
import 'package:nop_commerce/app/utils/requests.dart';
import 'package:nop_commerce/app/views/shop/all_categories_view.dart';
import 'package:nop_commerce/app/views/shop/category_products_view.dart';

class HomeController extends GetxController {
  var currentPage = 0.obs;
  CarouselSliderController productImageController = CarouselSliderController();
  var authenticationController = Get.find<AuthenticationController>();
  String get selectedCurrency =>
      authenticationController.stores[0].currencies[0].currencyCode;
  var selectedAttributes = RxMap<int, dynamic>();

  @override
  Future<void> onInit() async {
    super.onInit();
    await fetchCategories();
    await fetchProductList();
  }

  @override
  void onClose() {
    super.onClose();
  }

  var selectedIndex = 0.obs;

  void changeIndex(int index) {
    if (index == -1) return;
    if (Get.currentRoute != Routes.HOME) {
      Get.offNamed(Routes.HOME);
    }

    selectedIndex.value = index;
  }

//Categories

  var categories = <CategoryModel>[].obs;
  var subcategories = <CategoryModel>[].obs;
  Rx<CategoryModel> selectedCategory = CategoryModel().obs;
  Rx<CategoryModel> selectedSubCategory = CategoryModel().obs;
  var relatedSubcategories = <CategoryModel>[].obs;

  final CategoryService _categoryService = CategoryService();

  Future<void> onSelectCategory(CategoryModel category, bool navigate) async {
    relatedSubcategories = subcategories
        .where((sub) => sub.parentCategoryId == category.id)
        .toList()
        .obs;
    log("${category.name}${relatedSubcategories.toString()}");
    selectedCategory.value = category;
    if (relatedSubcategories.isNotEmpty && navigate == true) {
      Get.to(AllCategoriesView());
    } else if (relatedSubcategories.isEmpty && navigate == true) {
      selectedSubCategory.value = CategoryModel();
      await fetchCategoryProductList(category.id ?? 0);
      Get.to(() => CategoryProductsView());
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
  var categoryProductList = <Products>[].obs;
  var selectedProduct = Products().obs;

  final ProductService _productsService = ProductService();

  Future fetchProductList() async {
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

  Future fetchCategoryProductList(int id) async {
    try {
      ProductList? products =
          await _productsService.fetchProductsByCategory(id);
      if (products != null && products.products != null) {
        categoryProductList.assignAll(products.products!);
        categoryProductList.refresh();
        print('Category Products fetched: ${categoryProductList.length}');
      }
    } catch (e) {
      print(e.toString());
    } finally {}
  }

  /// add to cart
  Future<void> addToCart(int id, Map product, var productAttibutes,
      {bool addToWishList = false,
      int indexToNavigate = -1,
      int quantity = 1}) async {
    CartServices cartServices = CartServices();
    var response = await cartServices.addProductToCart(
        id, product, productAttibutes,
        addToWishList: addToWishList, quantity: quantity);
    if (response.statusCode == 200) {
      changeIndex(indexToNavigate);
    }
  }
}
