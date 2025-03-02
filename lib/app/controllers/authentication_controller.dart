import 'dart:developer';

import 'package:get/get.dart';
import 'package:nop_commerce/app/models/store_model.dart';
import 'package:nop_commerce/app/models/token_model.dart';
import 'package:nop_commerce/app/utils/requests.dart';

class AuthenticationController extends GetxController {
  var isLoading = false.obs;
  var authModel = TokenModel().obs;
  var stores = <StoreModel>[].obs;
  var accessToken = "".obs;
  var customerGuid = "".obs;

  @override
  void onInit() {
    super.onInit();
    _checkStoredToken();
  }

  Future<void> _checkStoredToken() async {
    if (Requests.box.hasData('access_token') &&
        Requests.box.hasData('customer_guid')) {
      accessToken.value = Requests.box.read('access_token');
      customerGuid.value = Requests.box.read('customer_guid');
      print("Token Loaded from Storage: ${accessToken.value}");
    } else {
      authModel.value = await Requests.requestNewToken() ?? TokenModel();
      accessToken.value = authModel.value.accessToken ?? "";
      customerGuid.value = authModel.value.customerGuid ?? "";
    }
    getCurrentStoreInformation();
  }

  Future<void> getCurrentStoreInformation() async {
    try {
      var response =
          await Requests.getDio(showLoadingDialog: false).get('stores/current');

      if (response.statusCode == 200) {
        var data = response.data;

        if (data is Map && data.containsKey('stores')) {
          List<StoreModel> storesList = (data['stores'] as List)
              .map((json) => StoreModel.fromJson(json as Map<String, dynamic>))
              .toList();
          stores.value = storesList;
          log(stores[0].toString());
        } else {
          log("Invalid response format: ${response.data}");
        }
      } else {
        log("Error: ${response.statusCode} - ${response.statusMessage}");
      }
    } catch (e) {
      log("Error fetching store information: $e");
    }
  }
}
