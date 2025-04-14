import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nop_commerce/app/services/recently_viewed_service.dart';
import 'package:nop_commerce/app/utils/extensions.dart';
import 'package:nop_commerce/app/views/shop/widgets/product_card.dart';

class RecentlyViewedItemsView extends StatelessWidget {
  RecentlyViewedItemsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _appBar(),
              12.SpaceX,
              _recentlyViewedGrid(),
            ],
          ),
        ),
      ),
    );
  }


  Widget _appBar(){
    return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Recently viewed',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(
                      Icons.close,
                      color: Colors.black,
                    ),
                  )
                ],
              );
  }

  Widget _recentlyViewedGrid() {
    return Builder(builder: (context) {
      var products = RecentlyViewedService.getRecentlyViewed();
      return Expanded(
        child: GridView.builder(
          shrinkWrap: true,
          itemCount: products.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: Get.width > 600 ? 3 : 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 4,
            childAspectRatio: 0.8,
          ),
          itemBuilder: (context, index) {
            final product = products[index];
            return ProductCard(product: product);
          },
        ),
      );
    });
  }
}
