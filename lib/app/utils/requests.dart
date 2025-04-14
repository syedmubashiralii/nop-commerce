import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:dio/src/response.dart' as DioResponse;
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nop_commerce/app/models/token_model.dart';
import 'package:nop_commerce/app/utils/constants.dart';
import 'package:nop_commerce/app/utils/custom_flash_widget.dart';
import 'package:nop_commerce/app/utils/dialogs/loading_dialog.dart';

class Requests {
  static String? cookie;
  static final Dio dio = Dio();
  static final box = GetStorage();

  static Dio getDio(
      {Map<String, String>? headers,
      bool showLoadingDialog = true,
      String? appUrl}) {
    headers ??= {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer ${box.read("access_token")}"
    };

    BaseOptions options = BaseOptions(
      baseUrl: appUrl ?? baseUrl,
      connectTimeout: const Duration(milliseconds: 30000),
      receiveTimeout: const Duration(milliseconds: 25000),
      validateStatus: (status) {
        if (status! == 401 || status == 403) {
          requestNewToken();
        }
        if (status == 502) {
          CustomFlashWidget.showFlashMessage(
              message: "Please try again later!".tr);
        }
        if (!(Get.isDialogOpen ?? false) && showLoadingDialog) {
          Get.dialog(const LoadingDialog());
        }
        return status <= 500;
      },
      headers: headers,
    );
    Dio d = Dio(options);
    var adapter = DefaultHttpClientAdapter();
    d.httpClientAdapter = adapter;
    d.interceptors.add(InterceptorsWrapper(
      onRequest:
          (RequestOptions options, RequestInterceptorHandler handler) async {
        log("${baseUrl}${options.path}");
        if (!(Get.isDialogOpen ?? false) && showLoadingDialog) {
          Get.dialog(const LoadingDialog());
        }
        return handler.next(options); //continue
      },
      onResponse: (DioResponse.Response response,
          ResponseInterceptorHandler handler) async {
        if ((Get.isDialogOpen ?? false) && showLoadingDialog) {
          Get.back();
        }
        if (kDebugMode && response.statusCode != 200) {
          print(response.data);
        }
        //  log(response.data.toString());
        return handler.next(response); // continue
      },
      onError: (DioError e, ErrorInterceptorHandler handler) async {
        if ((Get.isDialogOpen ?? false) && showLoadingDialog) {
          Get.back();
        }
        if (kDebugMode) {
          print(e.response?.data);
        }
        return handler.next(e); //continue
      },
    ));

    return d;
  }

  static Future<TokenModel?> requestNewToken() async {
    try {
      final response = await dio.post(
        'https://mobiledemo.herohero.store/token',
        data: {
          "guest": "true",
          "username": "",
          "password": "",
          "remember_me": "true",
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;
        TokenModel tokenModel = TokenModel.fromJson(data);
        box.write('access_token', tokenModel.accessToken);
        box.write('customer_guid', tokenModel.customerGuid);
        box.write('customer_id', tokenModel.customerId);
        return tokenModel;
      }
    } catch (e) {
      print('Error fetching new token: $e');
      return null;
    }
    return null;
  }

  static Future<bool> checkToken() async {
    final String? token = box.read("access_token");

    if (token == null || token.isEmpty) {
      print("No access token found.");
      return false;
    }

    final Dio gdio = Dio(
      BaseOptions(
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );

    try {
      final response =
          await gdio.get('https://mobiledemo.herohero.store/token/check');

      if (response.statusCode == 200) {
        print("✅ Token valid: ${response.data}");
        return true;
      } else {
        print("❌ Token check failed: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      print("⚠️ Error checking token: $e");
      return false;
    }
  }
}
