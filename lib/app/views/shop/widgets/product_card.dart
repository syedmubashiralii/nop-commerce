import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nop_commerce/app/controllers/home_controller.dart';
import 'package:nop_commerce/app/models/product_model.dart';
import 'package:nop_commerce/app/utils/extensions.dart';
import 'package:nop_commerce/app/views/shop/product_detail_view.dart';

class ProductCard extends GetView<HomeController> {
  const ProductCard({super.key,required this.product});
  final Products product;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        controller.selectedProduct.value = product;
        Get.to(() => ProductDetailView());
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 181,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(9),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 0,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            padding: const EdgeInsets.all(5),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(6),
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(
                      product.images != null ? product.images!.first.src! : '',
                    ),
                    fit: BoxFit.cover
                  )),
            ),
          ),
          6.SpaceX,
          Text(
            product.name ?? '',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
          1.SpaceX,
          RichText(
              text: TextSpan(
                  text: "${controller.selectedCurrency}",
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  children: [
                TextSpan(
                  text: "${product.price?.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                )
              ]))
        ],
      ),
    );
  }
}







