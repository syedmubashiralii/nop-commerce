import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingsController extends GetxController {
   var packageInfo = Rx<PackageInfo?>(null);
  Rx<String> formattedDate=''.obs;
 

  @override
  Future<void> onInit() async {
    super.onInit();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    PackageInfo info = await PackageInfo.fromPlatform();
    packageInfo.value = info;

    DateTime now = DateTime.now(); 
    formattedDate.value = DateFormat("MMMM,yyyy").format(now);
  }
}
