import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nop_commerce/app/modules/home/controllers/authentication_controller.dart';
import 'package:nop_commerce/app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  Get.put(AuthenticationController(), permanent: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Nop Commerce",
        theme: ThemeData(
          fontFamily: 'Raleway',
          scaffoldBackgroundColor: Colors.white,
        ),
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes);
  }
}
