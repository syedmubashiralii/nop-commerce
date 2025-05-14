import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nop_commerce/app/controllers/settings_controller.dart';
import 'package:nop_commerce/app/utils/extensions.dart';
import 'package:nop_commerce/app/utils/widgets/custom_button.dart';
import 'package:nop_commerce/app/utils/widgets/custom_text_field.dart';
import 'package:nop_commerce/app/views/settings/widgets/common_widgets.dart';

class LoginView extends GetView<SettingsController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: ListView(
          children: [
            const AppBarWidget(
              text: 'Login',
            ),
            20.SpaceX,
            const SubTitle(text: 'Welcome Back!'),
            20.SpaceX,
            CustomTextField(
              label: 'Email',
              controller: controller.emailController,
              hintText: 'you@example.com',
              keyboardType: TextInputType.emailAddress,
            ),
            12.SpaceX,
            Obx(() => CustomTextField(
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
                )),
            30.SpaceX,
            InkWell(
              onTap: () async {
                await controller.loginUser(); 
              },
              child: CustomButton(
                buttonText: 'Login',
              ),
            ),
          ],
        ),
      )),
    );
  }
}
