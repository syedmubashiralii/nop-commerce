import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nop_commerce/app/controllers/settings_controller.dart';
import 'package:nop_commerce/app/utils/extensions.dart';
import 'package:nop_commerce/app/views/settings/currency_view.dart';
import 'package:nop_commerce/app/views/settings/language_view.dart';
import 'package:nop_commerce/app/views/settings/profile_view.dart';
import 'package:nop_commerce/app/views/settings/shipping_address_view.dart';
import 'package:nop_commerce/app/views/settings/widgets/common_widgets.dart';

class SettingsView extends StatelessWidget {
  SettingsView({super.key});

  SettingsController controller = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppBarWidget(
                text: 'Settings',
              ),
              27.SpaceX,
              _subTitle('Personal'),
              33.SpaceX,
              _item('Profile', onTap: () {
                Get.to(() => ProfileView());
              }),
              25.SpaceX,
              _item('Shipping Address', onTap: () {
                Get.to(() => const ShippingAddressView());
              }),
              // 25.SpaceX,
              // _item('Payment methods'),
              31.SpaceX,
              _subTitle('Shop'),
              // 33.SpaceX,
              // Obx(
              //    () {
              //     return _item('Country', subValue: controller.selectedCountry.value, onTap: () {
              //       Get.to(() => CountryListView(shouldUpdate: true,));
              //     });
              //   }
              // ),
              
              22.SpaceX,
              Obx(() {
                return _item('Currency',
                    subValue: controller.selectedCurrency.value,
                    onTap: () {
                  Get.to(CurrencyView());
                });
              }),
              // 22.SpaceX,
              // Obx(() {
              //   return _item('Sizes', subValue: controller.selectedSize.value,
              //       onTap: () {
              //     Get.to(() => SizesView());
              //   });
              // }),
              22.SpaceX,
              _item('Terms and Conditions'),
              31.SpaceX,
              _subTitle('Account'),
              33.SpaceX,
              Obx(() {
                return _item('Language',
                    subValue: controller.selectedLanguage.value, onTap: () {
                  Get.to(() => LanguageView());
                });
              }),
              22.SpaceX,
              _item(
                  'About ${controller.authenticationController.stores[0].name}'),
              45.SpaceX,
              _deleteMyAccount(),
              31.SpaceX,
              _subTitle(controller.authenticationController.stores[0].name),
              2.SpaceX,
              _version(),
              35.SpaceX,
            ],
          ),
        ),
      )),
    );
  }

  Widget _subTitle(String text) {
    return Text(
      text,
      textAlign: TextAlign.left,
      style: const TextStyle(
          color: Colors.black, fontSize: 20, fontWeight: FontWeight.w800),
    );
  }

  Widget _item(String text, {String? subValue, VoidCallback? onTap}) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                textAlign: TextAlign.left,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
              Row(
                children: [
                  if (subValue != null)
                    Text(
                      subValue,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
                    ),
                  16.SpaceY,
                  const Icon(Icons.arrow_forward_ios_sharp),
                ],
              )
            ],
          ),
        ),
        25.SpaceX,
        const Divider(
          color: Color(0xffE6E6E6),
        )
      ],
    );
  }

  Widget _deleteMyAccount() {
    return const Text(
      'Delete My Account',
      style: TextStyle(
          fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xffD97474)),
    );
  }

  Widget _version() {
    return Obx(() {
      if (controller.packageInfo.value == null) {
        return const CircularProgressIndicator();
      }
      return Text(
        'Version ${controller.packageInfo.value!.version} ${controller.formattedDate.value}',
        style: const TextStyle(
            fontSize: 12, fontWeight: FontWeight.w400, color: Colors.black),
      );
    });
  }
}
