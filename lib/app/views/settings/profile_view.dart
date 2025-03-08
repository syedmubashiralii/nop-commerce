import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:nop_commerce/app/controllers/settings_controller.dart';
import 'package:nop_commerce/app/utils/color_helper.dart';
import 'package:nop_commerce/app/utils/extensions.dart';
import 'package:nop_commerce/app/utils/requests.dart';
import 'package:nop_commerce/app/utils/widgets/custom_button.dart';
import 'package:nop_commerce/app/utils/widgets/custom_text_field.dart';
import 'package:nop_commerce/app/views/settings/widgets/common_widgets.dart';

class ProfileView extends GetView<SettingsController> {
  ProfileView({super.key});

  final TextEditingController nameController =
      TextEditingController(text: "Romina");
  final TextEditingController emailController =
      TextEditingController(text: "gmail@example.com");
  final TextEditingController passwordController =
      TextEditingController(text: "**********");

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
            const SubTitle(text: 'Your Profile'),
            18.SpaceX,
            _profilePicture(),
            20.SpaceX,
            CustomTextField(controller: nameController),
            10.SpaceX,
            CustomTextField(controller: emailController),
            10.SpaceX,
            CustomTextField(controller: passwordController, obscureText: true),
            Spacer(),
            InkWell(
                onTap: () async {
                  // await controller.setCustomerData(data: {
                  //   "customer": {
                  //     'guid': Requests.box.read('customer_guid'),
                  //     "first_name": "<string>",
                  //     "last_name": "<string>",
                  //   }
                  // });
                },
                child: CustomButton(
                  buttonText: 'Save Changes',
                )),
            20.SpaceX,
          ],
        ),
      )),
    );
  }

  Widget _profilePicture() {
    return Stack(
      children: [
        Container(
          width: 92,
          height: 92,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 4),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 5,
                spreadRadius: 0,
                offset: const Offset(0, 0),
              ),
            ],
            image: const DecorationImage(
              image: NetworkImage("https://i.pravatar.cc/150?img=5"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 1,
          right: 1,
          child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ColorHelper.blueColor,
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: const Icon(Icons.edit_sharp, color: Colors.white, size: 16),
          ),
        ),
      ],
    );
  }
}
