import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nop_commerce/app/controllers/settings_controller.dart';
import 'package:nop_commerce/app/utils/extensions.dart';
import 'package:nop_commerce/app/utils/widgets/custom_radio_button.dart';
import 'package:nop_commerce/app/views/settings/widgets/common_widgets.dart';

class LanguageView extends GetView<SettingsController> {
  const LanguageView({super.key});

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
            const SubTitle(text: 'Language'),
            23.SpaceX,
            Expanded(
                child: ListView.builder(
              itemCount: controller
                  .authenticationController.stores[0].languages.length,
              itemBuilder: (context, index) {
                return Obx(() {
                  final language = controller
                      .authenticationController.stores[0].languages[index];
                  final isSelected =
                      controller.selectedLanguage.value == language.name;
                  return GestureDetector(
                    onTap: () {
                      controller.selectedLanguage.value = language.name;
                      controller.selectedLanguageID.value = language.id;
                      controller.updateCustomerLanguage();
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 16),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xffE5EBFC)
                            : const Color(0xffF9F9F9),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            language.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          CustomRadioButton(isSelected: isSelected)
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
