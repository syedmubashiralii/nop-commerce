import 'package:nop_commerce/app/utils/requests.dart';
import '../models/category_model.dart';

class CategoryService {
  Future getCategories() async {
    try {
      var response = await Requests.getDio().get('categories');
      if (response.statusCode == 200) {
        var data = response.data['categories'];
        return data;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  
}
