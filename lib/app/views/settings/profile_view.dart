import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nop_commerce/app/controllers/settings_controller.dart';
import 'package:nop_commerce/app/routes/app_pages.dart';
import 'package:nop_commerce/app/utils/color_helper.dart';
import 'package:nop_commerce/app/utils/extensions.dart';
import 'package:nop_commerce/app/utils/widgets/custom_button.dart';
import 'package:nop_commerce/app/utils/widgets/custom_drop_down_field.dart';
import 'package:nop_commerce/app/utils/widgets/custom_text_field.dart';
import 'package:nop_commerce/app/views/settings/login_view.dart';
import 'package:nop_commerce/app/views/settings/widgets/common_widgets.dart';

class ProfileView extends GetView<SettingsController> {
  ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    log(controller.selectedGender.value);
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppBarWidget(
              text: 'Settings',
            ),
            7.SpaceX,
            Obx(() {
              return SubTitle(
                  text: controller.customer.value?.email == "" ||
                          controller.customer.value?.email == null
                      ? 'Register'
                      : 'Your Profile');
            }),
            // 18.SpaceX,
            // _profilePicture(),
            20.SpaceX,
            CustomTextField(
              label: 'Username',
              controller: controller.userNameController,
              hintText: 'john.doe',
            ),
            10.SpaceX,
            CustomTextField(
              label: 'First Name',
              controller: controller.firstNameController,
              hintText: 'john',
            ),
            10.SpaceX,
            CustomTextField(
              label: 'Last Name',
              controller: controller.lastNameController,
              hintText: 'doe',
            ),
            10.SpaceX,
            CustomTextField(
              label: 'Email',
              controller: controller.emailController,
              hintText: 'john.doe@example.com',
            ),
            10.SpaceX,
            Obx(() => CustomTextField(
                  label: 'Date of Birth',
                  controller: TextEditingController(
                    text: controller.selectedDateOfBirth.value.isEmpty
                        ? ''
                        : controller.selectedDateOfBirth.value,
                  ),
                  hintText: 'Select your date of birth',
                  onChanged: (_) {},
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime(1990),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (pickedDate != null) {
                      controller.selectedDateOfBirth.value =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                    }
                  },
                  readOnly: true,
                )),

            10.SpaceX,
            CustomDropdownField<String>(
              value: controller.selectedGender.value,
              items: const ['Male', 'Female', 'Other'],
              label: 'Gender',
              hintText: 'Select Gender',
              onChanged: (val) {
                controller.selectedGender.value = val!;
              },
            ),
            10.SpaceX,
            Obx(() {
              return controller.customer.value?.email == "" ||
                      controller.customer.value?.email == null
                  ? CustomTextField(
                      label: 'Password',
                      controller: controller.passwordController,
                      hintText: '********',
                      obscureText: controller.hidePassword.value,
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.hidePassword.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          controller.hidePassword.value =
                              !controller.hidePassword.value;
                        },
                      ),
                    )
                  : const SizedBox();
            }),
            const SizedBox(
              height: 35,
            ),
            InkWell(onTap: () async {
              await controller.setCustomerData(
                  controller.customer.value?.email == "" ||
                          controller.customer.value?.email == null
                      ? true
                      : false);
            }, child: Obx(() {
              return CustomButton(
                buttonText: controller.customer.value?.email == "" ||
                        controller.customer.value?.email == null
                    ? 'Register'
                    : 'Save',
              );
            })),
            12.SpaceX,
            Obx(() {
              return controller.customer.value?.email == "" ||
                      controller.customer.value?.email == null
                  ? InkWell(
                      onTap: () async {
                        Get.toNamed(Routes.LOGIN);
                      },
                      child: CustomButton(
                        buttonText: 'Login',
                      ))
                  : InkWell(
                      onTap: () async {
                        await controller.logOutUser();
                      },
                      child: CustomButton(
                        buttonColor: Colors.red,
                        buttonText: 'LogOut',
                      ));
            }),
          ],
        ),
      )),
    );
  }

  Widget _profilePicture() {
    return Stack(
      children: [
        Container(
          width: 40,
          height: 40,
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
