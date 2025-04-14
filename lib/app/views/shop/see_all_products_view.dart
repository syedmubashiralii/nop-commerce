import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nop_commerce/app/controllers/home_controller.dart';
import 'package:nop_commerce/app/views/shop/widgets/product_card.dart';

class SeeAllProductsView extends GetView<HomeController> {
  const SeeAllProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(height: 16),
        const Text('All Items',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
        const SizedBox(height: 16),
        Expanded(
            child: GridView.builder(
          shrinkWrap: false,
          itemCount: controller
              .productList
              // .where((p) => p.showOnHomePage == true)
              .length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: Get.width > 600 ? 3 : 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 4,
            childAspectRatio: 0.8,
          ),
          itemBuilder: (context, index) {
            final products = controller.productList
                // .where((p) => p.showOnHomePage == true)
                .toList();
            final product = products[index];
            return ProductCard(product: product);
          },
        ))
      ]),
    )));
  }
}
