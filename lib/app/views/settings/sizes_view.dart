import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nop_commerce/app/controllers/settings_controller.dart';
import 'package:nop_commerce/app/utils/color_helper.dart';
import 'package:nop_commerce/app/utils/extensions.dart';
import 'package:nop_commerce/app/views/settings/widgets/common_widgets.dart';

class SizesView extends GetView<SettingsController> {
  SizesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppBarWidget(
              text: 'Settings',
            ),
            7.SpaceX,
            const SubTitle(text: 'Sizes'),
            23.SpaceX,
            Expanded(
                child: ListView.builder(
              itemCount: controller.sizes.length,
              itemBuilder: (context, index) {
                return Obx(() {
                  final size = controller.sizes[index];
                  final isSelected = controller.selectedSize.value == size;
                  return GestureDetector(
                    onTap: () {
                      controller.selectedSize.value = size;
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 16),
                      decoration: BoxDecoration(
                        color:
                            isSelected ? Color(0xffE5EBFC) : Color(0xffF9F9F9),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            size,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 2,
                              ),
                              color: isSelected
                                  ? ColorHelper.blueColor
                                  : Color(0xffF8CECE),
                            ),
                            child: isSelected
                                ? const Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 16,
                                  )
                                : null,
                          ),
                        ],
                      ),
                    ),
                  );
                });
              },
            )),
          ],
        ),
      )),
    );
  }
}
