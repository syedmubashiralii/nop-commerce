import 'package:nop_commerce/app/models/product_model.dart';
import 'package:nop_commerce/app/utils/requests.dart';

class ProductService {
  Future<ProductList?> fetchProducts() async {
    try {
      var response = await Requests.getDio().get('products');
      if (response.statusCode == 200) {
        print(response.data);
        return ProductList.fromJson(response.data);
      }
    } catch (e) {
      print("Error fetching products: $e");
    }
    return null;
  }

  Future<ProductList?> fetchProductsByCategory(int categoryid) async {
    try {
      var response =
          await Requests.getDio().get('products?CategoryId=${categoryid}');
      if (response.statusCode == 200) {
        return ProductList.fromJson(response.data);
      }
    } catch (e) {
      print("Error fetching products: $e");
    }
    return null;
  }


  
}
