import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nop_commerce/app/controllers/settings_controller.dart';
import 'package:nop_commerce/app/models/country_model.dart';
import 'package:nop_commerce/app/utils/color_helper.dart';
import 'package:nop_commerce/app/utils/custom_flash_widget.dart';
import 'package:nop_commerce/app/utils/extensions.dart';
import 'package:nop_commerce/app/utils/widgets/custom_radio_button.dart';
import 'package:nop_commerce/app/views/settings/widgets/common_widgets.dart';

class CurrencyView extends GetView<SettingsController> {
  CurrencyView({super.key});

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
            const SubTitle(text: 'Currency'),
            23.SpaceX,
            Expanded(
                child: ListView.builder(
              itemCount: controller
                  .authenticationController.stores[0].currencies.length,
              itemBuilder: (context, index) {
                return Obx(() {
                  final currency = controller
                      .authenticationController.stores[0].currencies[index];
                  final isSelected = controller.selectedCurrency.value ==
                      currency.currencyCode;
                  return GestureDetector(
                    onTap: () {
                      controller.selectedCurrency.value = currency.currencyCode;
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
                            currency.currencyCode,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          CustomRadioButton(isSelected:isSelected)
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
