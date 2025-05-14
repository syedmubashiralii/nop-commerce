import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:nop_commerce/app/controllers/home_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:nop_commerce/app/models/product_model.dart';
import 'package:nop_commerce/app/services/recently_viewed_service.dart';
import 'package:nop_commerce/app/utils/color_helper.dart';
import 'package:nop_commerce/app/utils/extensions.dart';
import 'package:nop_commerce/app/utils/widgets/custom_button.dart';
import 'package:nop_commerce/app/utils/widgets/custom_text_field.dart';

class ProductDetailView extends StatefulWidget {
  ProductDetailView({super.key});

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  final HomeController homeController = Get.find();
  bool isInit = false;

  @override
  Widget build(BuildContext context) {
    if (!isInit) {
      final product = homeController.selectedProduct.value;
      if (product.id != null) {
        RecentlyViewedService.addProduct(product);
        isInit = true;
      }
    }
    log(homeController.selectedProduct.value.toJson().toString());
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: _buildBottomBar(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_productImage(), 20.SpaceX, _productDetails()],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: const BoxDecoration(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              decoration: BoxDecoration(
                  color: const Color(0xffF9F9F9),
                  borderRadius: BorderRadius.circular(12)),
              height: 40,
              width: 47,
              child: IconButton(
                  onPressed: () {
                    homeController.addToWishList(
                        homeController.selectedProduct.value.id ?? 0,
                        homeController.selectedProduct.toJson(),
                        _buildSelectedAttributes(),
                        indexToNavigate: 1,
                        quantity: homeController
                                .selectedProduct.value.orderMinimumQuantity ??
                            1);
                  },
                  icon: const Icon(CupertinoIcons.heart))),
          const Spacer(),
          SizedBox(
              height: 40,
              width: 128,
              child: CustomButton(
                onTap: () {
                  if (kDebugMode) {
                    print(_buildSelectedAttributes());
                  }
                  homeController.addToCart(
                      homeController.selectedProduct.value.id ?? 0,
                      homeController.selectedProduct.toJson(),
                      _buildSelectedAttributes(),
                      indexToNavigate: 3,
                      quantity: homeController
                              .selectedProduct.value.orderMinimumQuantity ??
                          1);
                },
                buttonText: 'Add to Cart',
                buttonColor: ColorHelper.buttonBlack,
              )),
          16.SpaceY,
          SizedBox(
              height: 40,
              width: 128,
              child: CustomButton(
                onTap: () {
                  // homeController.buyNow(
                  //     homeController.selectedProduct.value.id ?? 0,
                  //     _buildSelectedAttributes());
                  homeController.addToCart(
                      homeController.selectedProduct.value.id ?? 0,
                      homeController.selectedProduct.toJson(),
                      _buildSelectedAttributes(),
                      indexToNavigate: 3,
                      quantity: homeController
                              .selectedProduct.value.orderMinimumQuantity ??
                          1);
                },
                buttonText: 'Buy Now',
                buttonColor: ColorHelper.blueColor,
              )),
        ],
      ),
    );
  }

  Widget _productImage() {
    return CarouselSlider(
      carouselController: homeController.productImageController,
      options: CarouselOptions(
        height: Get.height * .55,
        viewportFraction: 1,
        autoPlayAnimationDuration: const Duration(milliseconds: 1500),
        autoPlayInterval: const Duration(seconds: 7),
        onPageChanged: (index, _) {},
        autoPlay: true,
      ),
      items: homeController.selectedProduct.value.images?.map((i) {
        return SlideInRight(
          child: Container(
            height: Get.height * .55,
            decoration: const BoxDecoration(),
            child: CachedNetworkImage(
              imageUrl: i.src ?? "",
              fit: BoxFit.cover,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(
                  color: ColorHelper.blueColor,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _productDetails() {
    final product = homeController.selectedProduct.value;
    final tags = product.tags ?? [];
    var attributes = product.attributes ?? [];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
              text: TextSpan(
                  text: homeController.selectedCurrency,
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
              ])),
          6.SpaceX,
          Text(
            (product.name ?? "").capitalizeFirst ?? "",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          3.SpaceX,
          Text(
            '${product.approvedTotalReviews ?? ""} Reviews',
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          ),
          if ((product.orderMinimumQuantity ?? 0) > 1) 3.SpaceX,
          if ((product.orderMinimumQuantity ?? 0) > 1)
            Text(
              'Please note: A minimum order quantity of ${product.orderMinimumQuantity} is required.',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.redAccent,
              ),
            ),
          3.SpaceX,
          const Divider(),
          3.SpaceX,
          Html(data: product.fullDescription ?? ""),
          3.SpaceX,
          Text(
            'SKU: ${product.sku ?? ""}',
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          ),
          3.SpaceX,
          Text(
            'Availability: ${product.displayStockAvailability == true ? "InStock" : "Out of Stock" ?? ""}',
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          ),
          5.SpaceX,
          if (attributes.isNotEmpty) _buildAttributeFields(attributes),
          3.SpaceX,
          if (tags.isNotEmpty) _productTags(tags),
        ],
      ),
    );
  }

  Widget _productTags(List<String> tags) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Product Tags",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        Wrap(
          spacing: 6,
          children: tags
              .map((tag) => Chip(
                    color: const WidgetStatePropertyAll(Colors.white),
                    label: Text(tag),
                    backgroundColor: ColorHelper.blueColor.withOpacity(0.1),
                    labelStyle: const TextStyle(color: Colors.black),
                  ))
              .toList(),
        ),
      ],
    );
  }

  List<Map<String, dynamic>> _buildSelectedAttributes() {
    List<Map<String, dynamic>> selectedAttributes = [];

    final product = homeController.selectedProduct.value;
    var attributes = product.attributes ?? [];

    for (var attr in attributes) {
      // Get the selected attribute value
      var selectedValue = attr.attributeValues
          ?.firstWhereOrNull((v) => v.isPreSelected == true);

      if (selectedValue != null) {
        selectedAttributes.add({
          "value": selectedValue.id.toString(),
          "id": attr.id,
        });
      } else if (attr.defaultValue != null) {
        selectedAttributes.add({
          "value": attr.defaultValue.toString(),
          "id": attr.id,
        });
      }
    }

    return selectedAttributes;
  }

  Widget _buildAttributeFields(List<Attributes> attributes) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: attributes.map((attr) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (attr.textPrompt != null)
              Text(
                attr.textPrompt!,
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
            6.SpaceX,
            Text(attr.productAttributeName ?? "",
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            5.SpaceX,
            _buildControl(attr),
            6.SpaceX,
          ],
        );
      }).toList(),
    );
  }

  Widget _buildControl(Attributes attr) {
    switch (attr.attributeControlTypeId) {
      case 1:
        return DropdownButtonFormField<String>(
          value: attr.attributeValues
              ?.firstWhereOrNull((v) => v.isPreSelected == true)
              ?.name,
          items: attr.attributeValues?.map((v) {
            return DropdownMenuItem<String>(
              value: v.name,
              child: Text(v.name ?? ""),
            );
          }).toList(),
          dropdownColor: Colors.white,
          onChanged: (value) {
            attr.attributeValues?.forEach((val) {
              val.isPreSelected = (val.name == value);
            });
            homeController.selectedProduct.refresh();
            setState(() {});
          },
          decoration: InputDecoration(
            focusColor: ColorHelper.blueColor,
            border: const OutlineInputBorder(
                borderSide: BorderSide(color: ColorHelper.blueColor)),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: ColorHelper.blueColor)),
            hintText: "Select ${attr.productAttributeName}",
          ),
        );
      case 2:
        return Column(
          children: attr.attributeValues?.map((v) {
                return RadioListTile<String>(
                  fillColor:
                      const WidgetStatePropertyAll(ColorHelper.blueColor),
                  activeColor: ColorHelper.blueColor,
                  value: v.name ?? "",
                  groupValue: attr.attributeValues
                      ?.firstWhereOrNull((e) => e.isPreSelected == true)
                      ?.name,
                  onChanged: (val) {
                    attr.attributeValues?.forEach((element) {
                      element.isPreSelected = (element.name == val);
                    });
                    homeController.selectedProduct.refresh();
                    setState(() {});
                  },
                  title: Text(v.name ?? ""),
                );
              }).toList() ??
              [],
        );
      case 3:
        return Column(
          children: attr.attributeValues?.map((v) {
                return CheckboxListTile(
                  activeColor: ColorHelper.blueColor,
                  value: v.isPreSelected ?? false,
                  onChanged: (val) {
                    v.isPreSelected = val ?? false;
                    homeController.selectedProduct.refresh();
                    setState(() {});
                  },
                  title: Text(v.name ?? ""),
                );
              }).toList() ??
              [],
        );
      case 4:
        return CustomTextField(
          controller: TextEditingController(
            text: attr.defaultValue?.toString() ?? "",
          ),
          onChanged: (value) {
            attr.defaultValue = value;
            homeController.selectedProduct.refresh();
            setState(() {});
          },
        );

      case 45:
        // 🆕 ImageSquares case (newly added)
        return Wrap(
          spacing: 10,
          runSpacing: 10,
          children: attr.attributeValues?.map((v) {
                bool isSelected = v.isPreSelected ?? false;
                return GestureDetector(
                  onTap: () {
                    attr.attributeValues?.forEach((val) {
                      val.isPreSelected = false;
                    });
                    v.isPreSelected = true;
                    homeController.selectedProduct.refresh();
                    setState(() {});
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isSelected
                            ? ColorHelper.blueColor
                            : Colors.grey.shade300,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.all(6),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CachedNetworkImage(
                          imageUrl: v.imageSquaresImage?.src ?? '',
                          height: 80,
                          width: 80,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                        ),
                        6.SpaceX,
                        Text(
                          v.name ?? '',
                          style: TextStyle(
                            color: isSelected
                                ? ColorHelper.blueColor
                                : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList() ??
              [],
        );
      case 40:
        return Wrap(
          spacing: 8,
          children: attr.attributeValues?.map((value) {
                return GestureDetector(
                  onTap: () {
                    attr.attributeValues?.forEach((val) {
                      val.isPreSelected = false;
                    });
                    value.isPreSelected = true;
                    homeController.selectedProduct.refresh();
                    setState(() {});
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: _hexToColor(value.colorSquaresRgb ?? ""),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: value.isPreSelected == true
                            ? ColorHelper.blueColor
                            : Colors.grey,
                        width: value.isPreSelected == true ? 3 : 1,
                      ),
                    ),
                  ),
                );
              }).toList() ??
              [],
        );

      default:
        return const Text("Unsupported input type");
    }
  }

  Color _hexToColor(String hex) {
    hex = hex.replaceFirst('#', '');
    if (hex.length == 6) hex = 'FF$hex';
    return Color(int.parse(hex, radix: 16));
  }
}
