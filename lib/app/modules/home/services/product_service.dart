import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nop_commerce/app/modules/home/models/product_model.dart';
import 'package:nop_commerce/app/utils/constants.dart';

class ProductService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: baseUrl, // Replace with your API base URL
    headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
    },
  ));

  Future<ProductList?> fetchProducts() async {
    try {
      final box = GetStorage();
      String? token =
          box.read("access_token"); // Retrieve token from local storage

      if (token == null || token.isEmpty) {
        throw Exception("Authorization token is missing.");
      }

      final response = await _dio.get(
        "$baseUrl/products",
        options: Options(
          headers: {"Authorization": "Bearer $token"},
        ),
      );
      if (response.statusCode == 200) {
        print(response.data);
        return ProductList.fromJson(response.data);
      }
    } catch (e) {
      print("Error fetching products: $e");
    }
    return null;
  }
}
