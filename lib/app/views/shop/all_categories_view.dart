import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nop_commerce/app/controllers/home_controller.dart';
import 'package:nop_commerce/app/models/category_model.dart';
import 'package:nop_commerce/app/utils/color_helper.dart';
import 'package:nop_commerce/app/utils/custom_flash_widget.dart';
import 'package:nop_commerce/app/utils/extensions.dart';
import 'package:nop_commerce/app/views/shop/category_products_view.dart';

class AllCategoriesView extends StatelessWidget {
  AllCategoriesView({super.key});

  final HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: _fab(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [_appBar(), 20.SpaceX, _allCategories()],
            ),
          ),
        ),
      ),
    );
  }

  Widget _fab() {
    return InkWell(
      onTap: () async {
        var selectedCategory = homeController.selectedCategory.value;
        var selectedSubcategory = homeController.selectedSubCategory.value;
        var hasSubcategories = homeController.relatedSubcategories.isNotEmpty;

        if (selectedCategory.id == null) {
          CustomFlashWidget.showFlashMessage(
              message: "Please select a category.");
          return;
        }

        if (hasSubcategories && selectedSubcategory.id == null) {
          CustomFlashWidget.showFlashMessage(
              message: "Please select a subcategory.");
          return;
        }

        int id = (hasSubcategories && selectedSubcategory.id != null)
            ? selectedSubcategory.id!
            : selectedCategory.id!;

        await homeController.fetchCategoryProductList(id);
        Get.to(()=>CategoryProductsView());

      },
      child: const CircleAvatar(
        backgroundColor: ColorHelper.blueColor,
        child: Icon(
          Icons.arrow_forward_rounded,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _appBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'All Categories',
          style: TextStyle(
              color: Colors.black, fontSize: 28, fontWeight: FontWeight.w700),
        ),
        IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.close,
              color: Colors.black,
            ))
      ],
    );
  }

  Widget _allCategories() {
    return Obx(() => ListView.separated(
          shrinkWrap: true,
          itemCount: homeController.categories.length,
          separatorBuilder: (_, __) => const SizedBox(height: 6),
          itemBuilder: (context, index) {
            var category = homeController.categories[index];

            return Obx(() {
              bool isSelected =
                  homeController.selectedCategory.value.id == category.id;
              return Column(
                children: [
                  InkWell(
                    onTap: () {
                      if (!isSelected) {
                        homeController.onSelectCategory(category, true);
                        homeController.selectedSubCategory.value =
                            CategoryModel();
                        homeController.selectedSubCategory.refresh();
                      } else {
                        homeController.selectedCategory.value = CategoryModel();
                        homeController.selectedCategory.refresh();
                        homeController.selectedSubCategory.value =
                            CategoryModel();
                        homeController.selectedSubCategory.refresh();
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(7),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                            color: Colors.black.withOpacity(.1),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: FadeInImage.assetNetwork(
                              placeholder: 'assets/images/loading.gif',
                              image: category.image?.src ?? "",
                              height: 44,
                              width: 44,
                              fit: BoxFit.cover,
                              imageErrorBuilder: (_, __, ___) => Image.asset(
                                'assets/images/placeholder.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Text(
                            category.name ?? "",
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w700),
                          ),
                          const Spacer(),
                          Icon(
                            isSelected
                                ? Icons.keyboard_arrow_up_rounded
                                : Icons.keyboard_arrow_down_rounded,
                            color: isSelected
                                ? ColorHelper.blueColor
                                : Colors.black,
                          ),
                          20.SpaceY
                        ],
                      ),
                    ),
                  ),
                  if (isSelected) _buildSubcategories(),
                ],
              );
            });
          },
        ));
  }

  Widget _buildSubcategories() {
    return Obx(() {
      if (homeController.relatedSubcategories.isEmpty)
        return const SizedBox.shrink();

      return Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 20),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 4,
          ),
          itemCount: homeController.relatedSubcategories.length,
          itemBuilder: (_, index) {
            var subcategory = homeController.relatedSubcategories[index];
            return Obx(() {
              bool isSelected =
                  homeController.selectedSubCategory.value.id == subcategory.id;
              return InkWell(
                onTap: () {
                  if(isSelected)
                  {
                    homeController.selectedSubCategory.value=CategoryModel();
                    return;
                  }
                  homeController.selectedSubCategory.value = subcategory;
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: isSelected
                            ? ColorHelper.blueColor
                            : const Color(0xffFFEBEB),
                        width: 2),
                  ),
                  child: Text(
                    subcategory.name ?? "",
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                ),
              );
            });
          },
        ),
      );
    });
  }
}
