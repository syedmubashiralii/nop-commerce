import 'package:flutter/material.dart';
import 'dart:async';

import 'package:get/get.dart';
import 'package:nop_commerce/app/controllers/authentication_controller.dart';
import 'package:nop_commerce/app/routes/app_pages.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  AuthenticationController authenticationController =
      Get.put(AuthenticationController());
  @override
  void initState() {
    super.initState();
    _goToHome();
  }

  _goToHome() async {
    await authenticationController.checkStoredToken();
    Timer(const Duration(seconds: 1), () {
      Get.offNamed(Routes.HOME);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: FlutterLogo(size: 100),
      ),
    );
  }
}
