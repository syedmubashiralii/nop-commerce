import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:nop_commerce/app/modules/home/models/token_model.dart';

class AuthenticationController extends GetxController {
  var isLoading = false.obs;
  var authModel = TokenModel().obs;
  String baseUrl = "https://mobiledemo.herohero.store";

  // Observables
  var accessToken = "".obs;
  var customerGuid = "".obs;

  final storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    _checkStoredToken();
  }

  // Check if token is stored in local storage
  // ✅ Check if token exists in storage, otherwise fetch it
  void _checkStoredToken() {
    if (storage.hasData('access_token') && storage.hasData('customer_guid')) {
      accessToken.value = storage.read('access_token');
      customerGuid.value = storage.read('customer_guid');
      print("Token Loaded from Storage: ${accessToken.value}");
    } else {
      getToken(); // Call API to fetch token if not stored
    }
  }

  // ✅ Fetch token from API
  Future<void> getToken() async {
    String url = "$baseUrl/token";
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          // 'Authorization': 'Bearer YOUR_BEARER_TOKEN'
        },
        body: jsonEncode({
          "guest": "true",
          "username": "",
          "password": "",
          "remember_me": "true"
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        TokenModel tokenModel = TokenModel.fromJson(data);

        // Save in GetStorage
        storage.write('access_token', tokenModel.accessToken);
        storage.write('customer_guid', tokenModel.customerGuid);

        // Update observable values
        accessToken.value = tokenModel.accessToken!;
        customerGuid.value = tokenModel.customerGuid!;

        print("New Token Fetched and Saved: ${tokenModel.accessToken}");
      } else {
        print("Failed to fetch token: ${response.body}");
      }
    } catch (e) {
      print("Error fetching token: $e");
    }
  }
}
