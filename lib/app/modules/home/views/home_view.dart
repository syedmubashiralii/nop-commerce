import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nop_commerce/app/modules/home/controllers/home_controller.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Obx(() => screens[controller.selectedIndex.value])),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            currentIndex: controller.selectedIndex.value,
            onTap: controller.changeIndex,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.blue,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home, size: Get.width * 0.07),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border, size: Get.width * 0.07),
                label: 'Favorites',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.article_outlined, size: Get.width * 0.07),
                label: 'Orders',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_bag_outlined, size: Get.width * 0.07),
                label: 'Cart',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline, size: Get.width * 0.07),
                label: 'Profile',
              ),
            ],
          )),
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
            SizedBox(height: 20), // 🛠 Add spacing for better UI
            categoriesWidgets(), // ✅ Add Categories section
            SizedBox(height: 20), // 🛠 Add spacing for better UI
            _topProducts(),
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
                        ? Colors.blue
                        : Colors.grey,
                    borderRadius: BorderRadius.circular(4),
                  ),
                );
              }),
            ),
          ],
        ));
  }

  /// ✅ **Categories Widget**
  Widget categoriesWidgets() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Categories',
                style: TextStyle(
                  fontSize: Get.width * 0.06,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Row(
                  children: [
                    Text(
                      'See All',
                      style: TextStyle(
                        fontSize: Get.width * 0.045,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(Icons.arrow_forward, size: Get.width * 0.05),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: Get.height * 0.02),
          Obx(() => GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: Get.width * 0.04,
                  mainAxisSpacing: Get.height * 0.02,
                  childAspectRatio: 1,
                ),
                itemCount: controller.categories.length,
                itemBuilder: (context, index) {
                  final category = controller.categories[index];
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5,
                          spreadRadius: 2,
                        )
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Column(
                        children: [
                          // 🛠 **Updated Grid to 4 images instead of 2**
                          Expanded(
                            child: GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 5,
                                mainAxisSpacing: 5,
                              ),
                              itemCount: category['images'].length >= 4
                                  ? 4
                                  : category['images'].length,
                              itemBuilder: (context, imgIndex) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    category['images'][imgIndex],
                                    fit: BoxFit.cover,
                                  ),
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(Get.width * 0.02),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  category['title'],
                                  style: TextStyle(
                                    fontSize: Get.width * 0.045,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.blue[100],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    category['count'].toString(),
                                    style: TextStyle(
                                      fontSize: Get.width * 0.04,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )),
        ],
      ),
    );
  }

  // Top Products Widgets
  Widget _topProducts() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Top Products",
            style: TextStyle(
              fontSize: Get.width * 0.05,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: Get.height * 0.02),
          Obx(
            () => SizedBox(
              height: Get.width * 0.18,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.topProducts.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
                    child: CircleAvatar(
                      radius: Get.width * 0.09,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: Get.width * 0.085,
                        backgroundImage:
                            AssetImage(controller.topProducts[index]),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
