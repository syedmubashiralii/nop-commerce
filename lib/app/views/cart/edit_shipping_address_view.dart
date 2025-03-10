import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nop_commerce/app/utils/color_helper.dart';
import 'package:nop_commerce/app/utils/extensions.dart';
import 'package:nop_commerce/app/utils/widgets/custom_button.dart';
import 'package:nop_commerce/app/utils/widgets/custom_text_field.dart';
import 'package:nop_commerce/app/views/settings/country_list_view.dart';

class EditShippingAddressView extends StatelessWidget {
  EditShippingAddressView({super.key});

  void show() {
    showModalBottomSheet(
      context: navigator!.context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      constraints: BoxConstraints(maxHeight: Get.height * .7),
      builder: (context) {
        return this;
      },
    );
  }

  final TextEditingController addressController = TextEditingController();
  final TextEditingController townController = TextEditingController();
  final TextEditingController postCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 80,
              decoration: const BoxDecoration(
                color: Color(0xffF8FAFF),
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Text(
                "Shipping Address",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  14.SpaceX,
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
                  16.SpaceX,
                  CustomButton(
                    buttonText: 'Save Changes',
                  ),
                  20.SpaceX
                ],
              ),
            )
          ],
        ),
      ),
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
