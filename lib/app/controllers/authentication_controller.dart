import 'dart:developer';

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:nop_commerce/app/models/store_model.dart';
import 'package:nop_commerce/app/models/token_model.dart';
import 'package:nop_commerce/app/utils/requests.dart';

class AuthenticationController extends GetxController {
  var isLoading = false.obs;
  var authModel = TokenModel().obs;
  var stores = <StoreModel>[].obs;
  var accessToken = "".obs;
  var customerGuid = "".obs;
  var customerId = 0.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    _checkStoredToken();
  }

  Future<void> _checkStoredToken() async {
    final hasToken = Requests.box.hasData('access_token');
    final hasGuid = Requests.box.hasData('customer_guid');
    final hasId = Requests.box.hasData('customer_id');

    if (hasToken && hasGuid && hasId) {
      accessToken.value = Requests.box.read('access_token') ?? "";
      customerGuid.value = Requests.box.read('customer_guid') ?? "";
      customerId.value = Requests.box.read('customer_id') ?? 0;

      print("✅ Token loaded from storage: ${accessToken.value}");

      final tokenIsValid = await Requests.checkToken();
      if (!tokenIsValid) {
        print("⚠️ Stored token invalid, requesting new token...");
        await _requestAndStoreNewToken();
      }
    } else {
      print("🔑 No stored token found, requesting new token...");
      await _requestAndStoreNewToken();
    }

    getCurrentStoreInformation();
  }

  Future<void> _requestAndStoreNewToken() async {
    authModel.value = await Requests.requestNewToken() ?? TokenModel();
    accessToken.value = authModel.value.accessToken ?? "";
    customerGuid.value = authModel.value.customerGuid ?? "";
    customerId.value = authModel.value.customerId ?? 0;

    // Optional: Save back to storage if needed
    Requests.box.write('access_token', accessToken.value);
    Requests.box.write('customer_guid', customerGuid.value);
    Requests.box.write('customer_id', customerId.value);

    print("✅ New token fetched and stored.");
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
