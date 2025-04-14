import 'package:get_storage/get_storage.dart';
import 'package:nop_commerce/app/models/product_model.dart';

class RecentlyViewedService {
  static final box = GetStorage();
  static const String _key = 'recently_viewed';

  static List<Map<String, dynamic>> _getRawList() {
    return box.read<List>(_key)?.cast<Map<String, dynamic>>() ?? [];
  }

  static List<Products> getRecentlyViewed() {
    return _getRawList().map((e) => Products.fromJson(e)).toList();
  }

  static void addProduct(Products product) {
    final rawList = _getRawList();
    rawList.removeWhere((element) => element['id'] == product.id); 
    rawList.insert(0, product.toJson());

    // Limit to 10 items max
    if (rawList.length > 10) rawList.removeLast();

    box.write(_key, rawList);
  }

  static void clearAll() => box.remove(_key);

  static void removeItem(int productId) {
    final rawList = _getRawList();
    rawList.removeWhere((element) => element['id'] == productId);
    box.write(_key, rawList);
  }
}
