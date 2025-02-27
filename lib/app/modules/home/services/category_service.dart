import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nop_commerce/app/utils/constants.dart';
import '../models/category_model.dart';

class CategoryService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: baseUrl, // Replace with your API base URL
    headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
    },
  ));

  Future<List<Category>> getCategories() async {
    try {
      final box = GetStorage();
      String? token =
          box.read("access_token"); // Retrieve token from local storage

      if (token == null || token.isEmpty) {
        throw Exception("Authorization token is missing.");
      }

      Response response = await _dio.get(
        "/categories",
        options: Options(
          headers: {"Authorization": "Bearer $token"},
        ),
      );

      if (response.statusCode == 200) {
        List data = response.data; // Assuming API returns a list
        return data.map((json) => Category.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load categories");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}
