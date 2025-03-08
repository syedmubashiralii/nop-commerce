import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nop_commerce/app/controllers/authentication_controller.dart';
import 'package:nop_commerce/app/models/country_model.dart';
import 'package:nop_commerce/app/models/store_model.dart';
import 'package:nop_commerce/app/utils/requests.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingsController extends GetxController {
  List<String> sizes = ['US', 'EU', 'UK'];
  AuthenticationController authenticationController = Get.find();
  var packageInfo = Rx<PackageInfo?>(null);
  Rx<String> formattedDate = ''.obs;
  RxList<CountryModel> countryList = <CountryModel>[].obs;
  var selectedLanguage = 'EN'.obs;
  var selectedCurrency = 'USD'.obs;
  var selectedSize = 'UK'.obs;
  var selectedCountry = ''.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    _initPackageInfo();
   
    fetchCurrentCustomer();
  }

  Future<void> _initPackageInfo() async {
    PackageInfo info = await PackageInfo.fromPlatform();
    packageInfo.value = info;

    DateTime now = DateTime.now();
    formattedDate.value = DateFormat("MMMM,yyyy").format(now);
  }

  Future fetchAllCountries() async {
    var response = await Requests.getDio().get('countries');
    print(response.data);
    if (response.statusCode == 200) {
      countryList.value = CountryModel.listFromJson(response.data['countries']);
      countryList.refresh();
      print(countryList.length);
    }
  }

  Future fetchCurrentCustomer() async {
    var response = await Requests.getDio().get('customers/me');
    log(response.data.toString());
    if (response.statusCode == 200) {}
  }

  Future setCustomerData({required Map data}) async {
    var response = await Requests.getDio().post('customers', data: data);
    log(response.data.toString());
    if (response.statusCode == 200) {}
  }
}
