import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nop_commerce/app/modules/home/controllers/home_controller.dart';
import 'package:nop_commerce/app/modules/home/models/product_model.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});

  final HomeController controller = Get.find();

// Screens
  final List<Widget> screens = [
    HomeMenuScreen(),
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
      resizeToAvoidBottomInset: false, // Prevents bottom bar from moving up
      bottomNavigationBar: customBottomBar(),
      body: Obx(() => screens[controller.selectedIndex.value]),
    );
  }

  Obx customBottomBar() {
    return Obx(
      () => Container(
        padding: EdgeInsets.symmetric(vertical: Get.height * 0.015),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(iconPaths.length, (index) {
            return GestureDetector(
              onTap: () => controller.changeIndex(index),
              child: Image.asset(
                iconPaths[index],
                width: Get.width * 0.07,
                color: controller.selectedIndex.value == index
                    ? Colors.black
                    : const Color.fromARGB(255, 0, 76, 255),
              ),
            );
          }),
        ),
      ),
    );
  }
}

// Home Screen (Shop)

class HomeMenuScreen extends StatelessWidget {
  final HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text('Shop',
                style: TextStyle(
                    fontSize: Get.width * 0.06, fontWeight: FontWeight.bold)),
            SizedBox(width: Get.width * 0.02),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  suffix: Icon(
                    Icons.camera_alt_outlined,
                    size: Get.width * 0.07,
                    color: Colors.blue,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSlider(), // ✅ Add Slider at the top
            const SizedBox(height: 20), // 🛠 Add spacing for better UI
            categoriesWidgets(), // ✅ Add Categories section
            const SizedBox(height: 10), // 🛠 Add spacing for better UI
            _allItemsHeader(), // ✅ Add "All Items" header
            const SizedBox(height: 15), // 🛠 Add spacing for better UI
            Obx(
              () => controller.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : GridView.builder(
                      shrinkWrap: true, // Prevents infinite height issues
                      physics:
                          const NeverScrollableScrollPhysics(), // Disables GridView's scrolling
                      itemCount: controller.productList
                          .where((p) => p.showOnHomePage == true)
                          .length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: Get.width > 600 ? 3 : 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.7,
                      ),
                      itemBuilder: (context, index) {
                        final products = controller.productList
                            .where((p) => p.showOnHomePage == true)
                            .toList();
                        final product = products[index];
                        return _productCard(product);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  /// ✅ **Slider Widget**
  Widget _buildSlider() {
    return Obx(() => Column(
          children: [
            Container(
              width: Get.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.amber,
              ),
              height: Get.height * 0.25,
              margin: const EdgeInsets.all(10),
              child: PageView.builder(
                controller: controller.pageController,
                itemCount: 4,
                onPageChanged: (index) {
                  controller.currentPage.value = index;
                },
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/big_sale.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Big Sale',
                              style: TextStyle(
                                  fontSize: Get.width * 0.07,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                          const SizedBox(height: 5),
                          Text('Up to 50%',
                              style: TextStyle(
                                  fontSize: Get.width * 0.05,
                                  color: Colors.white)),
                          const SizedBox(height: 5),
                          Text('Happening Now',
                              style: TextStyle(
                                  fontSize: Get.width * 0.04,
                                  color: Colors.white)),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: controller.currentPage.value == index ? 20 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: controller.currentPage.value == index
                        ? const Color(0xFF0C8AF2)
                        : Colors.grey,
                    borderRadius: BorderRadius.circular(4),
                  ),
                );
              }),
            ),
          ],
        ));
  }

  /// ✅ **Updated Categories Widget with Circular Design**
  Widget categoriesWidgets() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Text(
          //       'Categories',
          //       style: TextStyle(
          //         fontSize: Get.width * 0.06,
          //         fontWeight: FontWeight.bold,
          //       ),
          //     ),
          //     TextButton(
          //       onPressed: () {},
          //       child: Row(
          //         children: [
          //           Text(
          //             'See All',
          //             style: TextStyle(
          //               fontSize: Get.width * 0.045,
          //               fontWeight: FontWeight.bold,
          //             ),
          //           ),
          //           Icon(Icons.arrow_forward, size: Get.width * 0.05),
          //         ],
          //       ),
          //     ),
          //   ],
          // ),
          SizedBox(height: Get.height * 0.02),
          Obx(
            () => GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: Get.width * 0.02,
                mainAxisSpacing: Get.height * 0.02,
                childAspectRatio: 1,
              ),
              itemCount: controller.categories.length,
              itemBuilder: (context, index) {
                final category = controller.categories[index];
                return Column(
                  children: [
                    Container(
                      width: Get.width * 0.17,
                      height: Get.width * 0.17,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 5,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: FadeInImage.assetNetwork(
                          placeholder: 'assets/images/loading.gif',
                          image: category.image.src,
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
                    SizedBox(height: Get.height * 0.01),
                    Text(
                      category.name,
                      style: TextStyle(
                        fontSize: Get.width * 0.033,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // All Items Header
  Widget _allItemsHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // "All Items" Text
          Text(
            "All Items",
            style: TextStyle(
              fontSize: Get.width * 0.05,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),

          // Filter Icon
          Image.asset('assets/icons/filter_icon.png', width: Get.width * 0.06),
          // Icon(
          //   Icons.tune, // This closely matches the filter icon in your image
          //   size: Get.width * 0.06,
          //   color: Colors.black,
          // ),
        ],
      ),
    );
  }

  // Top Products Widgets
  Widget _productGrid() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Obx(
        () => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : GridView.builder(
                itemCount: controller.productList
                    .where((p) => p.showOnHomePage == true)
                    .length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: Get.width > 600 ? 3 : 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.7,
                ),
                itemBuilder: (context, index) {
                  final products = controller.productList
                      .where((p) => p.showOnHomePage == true)
                      .toList();
                  final product = products[index];
                  return _productCard(product);
                },
              ),
      ),
    );
  }

  Widget _productCard(Products product) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // Light shadow
            blurRadius: 8,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Image.network(
                product.images != null ? product.images!.first.src! : '',
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(height: 8),

          // Product Title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              product.name ?? '',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),

          const SizedBox(height: 4),

          // Product Price
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              "\$${product.price?.toStringAsFixed(2)}",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
