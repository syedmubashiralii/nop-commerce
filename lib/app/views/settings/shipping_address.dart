import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:nop_commerce/app/utils/color_helper.dart';
import 'package:nop_commerce/app/utils/extensions.dart';
import 'package:nop_commerce/app/utils/widgets/custom_button.dart';
import 'package:nop_commerce/app/utils/widgets/custom_text_field.dart';
import 'package:nop_commerce/app/views/settings/country_list_view.dart';
import 'package:nop_commerce/app/views/settings/widgets/common_widgets.dart';

class ShippingAddressView extends StatelessWidget {
  ShippingAddressView({super.key});

  final TextEditingController addressController = TextEditingController();
  final TextEditingController townController = TextEditingController();
  final TextEditingController postCodeController = TextEditingController();

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
            const SubTitle(text: 'Shipping Address'),
            25.SpaceX,
            const Text(
              'Country',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            2.SpaceX,
            _chooseCountry(),
            23.SpaceX,
            CustomTextField(
              controller: addressController,
              label: 'Address',
              hintText: 'Required',
            ),
            10.SpaceX,
            CustomTextField(
              controller: townController,
              label: 'Town/City',
              hintText: 'Required',
            ),
            10.SpaceX,
            CustomTextField(
              controller: postCodeController,
              label: 'Postcode',
              hintText: 'Required',
            ),
            const Spacer(),
            CustomButton(
              buttonText: 'Save Changes',
            ),
            20.SpaceX,
          ],
        ),
      )),
    );
  }

  Widget _chooseCountry() {
    return InkWell(
      onTap: () {
        Get.to(() => CountryListView());
      },
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Choose your country',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          CircleAvatar(
            radius: 15,
            backgroundColor: ColorHelper.blueColor,
            child: Icon(
              Icons.arrow_forward_sharp,
              color: Colors.white,
              size: 20,
            ),
          )
        ],
      ),
    );
  }
}
