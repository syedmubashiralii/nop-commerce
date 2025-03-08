import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nop_commerce/app/controllers/settings_controller.dart';
import 'package:nop_commerce/app/utils/extensions.dart';
import 'package:nop_commerce/app/views/settings/profile_view.dart';
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
             AppBarWidget(text: 'Settings',),
              27.SpaceX,
              _subTitle('Personal'),
              33.SpaceX,
              _item('Profile',onTap: (){
                Get.to(ProfileView());
              }),
              25.SpaceX,
              _item('Shipping Address'),
              25.SpaceX,
              _item('Payment methods'),
              31.SpaceX,
              _subTitle('Shop'),
              33.SpaceX,
              _item('Country', subValue: 'Vietnam'),
              22.SpaceX,
              _item('Country', subValue: '\$ USD'),
              22.SpaceX,
              _item('Sizes', subValue: 'UK'),
              22.SpaceX,
              _item('Terms and Conditions', subValue: 'UK'),
              31.SpaceX,
              _subTitle('Account'),
              33.SpaceX,
              _item('Language', subValue: 'English'),
              22.SpaceX,
              _item('About Slada'),
              45.SpaceX,
              _deleteMyAccount(),
              31.SpaceX,
              _subTitle('Slada'),
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

  Widget _item(String text, {String? subValue,VoidCallback? onTap}) {
    return Column(
      children: [
        InkWell(
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
