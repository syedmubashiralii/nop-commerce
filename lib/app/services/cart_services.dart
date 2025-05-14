import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:nop_commerce/app/models/cart_model.dart';
import 'package:nop_commerce/app/utils/custom_flash_widget.dart';
import 'package:nop_commerce/app/utils/requests.dart';

class CartServices {
  Future<CartModel?> getShoppingCart() async {
    try {
      var response = await Requests.getDio().get('shopping_cart_items?ShoppingCartType=ShoppingCart&CustomerId=${Requests.box.read('customer_id') ?? 0}');
      if (response.statusCode == 200) {
        var shoppingCartModel = CartModel.fromJson(response.data);
        // log('Parsed shopping cart model: ${shoppingCartModel.toJson()}');
        return shoppingCartModel;
      } else {
        log('Failed to load shopping cart items. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      log('Error fetching shopping cart items: $e');
      return null;
    }
  }



   Future<CartModel?> getWishListData() async {
    try {
      var response = await Requests.getDio().get('shopping_cart_items?ShoppingCartType=Wishlist&CustomerId=${Requests.box.read('customer_id') ?? 0}');
      if (response.statusCode == 200) {
        var shoppingCartModel = CartModel.fromJson(response.data);
        return shoppingCartModel;
      } else {
        log('Failed to load shopping cart items. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      log('Error fetching shopping cart items: $e');
      return null;
    }
  }

  Future<Response> addProductToCart(
      int productId, Map product, var productAttibutes,
      {int quantity = 1}) async {
    int customerId = Requests.box.read('customer_id') ?? 0;
    print('addProductToCart${productAttibutes}');
    var response = await Requests.getDio().post('shopping_cart_items', data: {
      "shopping_cart_item": {
        "shopping_cart_type": "ShoppingCart",
        "product_attributes": productAttibutes,
        "customer_id": customerId,
        "product_id": productId,
        "product": product,
        "quantity": quantity,
      }
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      CustomFlashWidget.showFlashMessage(
          message: 'Added to Cart',
          type: FlashType.success);
    } else {
      String errorMessage = 'Failed to add to cart.';
      var errorData = response.data;
      if (errorData['errors'] != null &&
          errorData['errors']['shopping cart item'] != null &&
          errorData['errors']['shopping cart item'].isNotEmpty) {
        errorMessage = errorData['errors']['shopping cart item'][0];
      }
      CustomFlashWidget.showFlashMessage(message: errorMessage);
    }
    return response;
  }


  Future<Response> addProductToWishList(
      int productId, Map product, var productAttibutes,
      { int quantity = 1}) async {
    int customerId = Requests.box.read('customer_id') ?? 0;
    print('addProductTowishlist${productAttibutes}');
    var response = await Requests.getDio().post('shopping_cart_items', data: {
      "shopping_cart_item": {
        "shopping_cart_type": "Wishlist",
        "product_attributes": productAttibutes,
        "customer_id": customerId,
        "product_id": productId,
        "product": product,
        "quantity": quantity,
      }
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      CustomFlashWidget.showFlashMessage(
          message: 'Added to Wishlist',
          type: FlashType.success);
    } else {
      String errorMessage = 'Failed to add to wishlist.';
      var errorData = response.data;
      if (errorData['errors'] != null &&
          errorData['errors']['shopping cart item'] != null &&
          errorData['errors']['shopping cart item'].isNotEmpty) {
        errorMessage = errorData['errors']['shopping cart item'][0];
      }
      CustomFlashWidget.showFlashMessage(message: errorMessage);
    }
    return response;
  }

  Future updateProductQuantity(int id, int productId, int quantity) async {
    int customerId = Requests.box.read('customer_id') ?? 0;
    var response =
        await Requests.getDio().put('shopping_cart_items/$id', data: {
      "shopping_cart_item": {
        "customer_id": customerId,
        "shopping_cart_type": "ShoppingCart",
        "quantity": quantity,
        "product_id": productId,
        // "product": items
      }
    });
    log('shopping_cart_items/$productId ${response}');
  }

  Future removeProductFromCart(int id) async {
    var response = await Requests.getDio().delete('shopping_cart_items/$id');
    print('shopping_cart_items_remove ${response.data}');
  }

  // Future addProductToWishList(
  //     int productId, Map product, var productAttibutes) async {
  //   int customerId = Requests.box.read('customer_id') ?? 0;
  //   print('addProductToCart${productAttibutes}');
  //   var response = await Requests.getDio().post('shopping_cart_items', data: {
  //     "shopping_cart_item": {
  //       "shopping_cart_type": "Wishlist",
  //       "product_attributes": productAttibutes,
  //       "customer_id": customerId,
  //       "product_id": productId,
  //       "product": product,
  //       "quantity": 1,
  //     }
  //   });
  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     CustomFlashWidget.showFlashMessage(
  //         message: 'Added to Cart', type: FlashType.success);
  //   } else {
  //     String errorMessage = 'Failed to add to cart.';
  //     var errorData = response.data;
  //     if (errorData['errors'] != null &&
  //         errorData['errors']['shopping cart item'] != null &&
  //         errorData['errors']['shopping cart item'].isNotEmpty) {
  //       errorMessage = errorData['errors']['shopping cart item'][0];
  //     }
  //     CustomFlashWidget.showFlashMessage(message: errorMessage);
  //   }
  // }


  Future moveToCart(int productId, int cartItemID) async {
    int customerId = Requests.box.read('customer_id') ?? 0;
    var response =  await Requests.getDio().put('shopping_cart_items/$cartItemID', data: {
      "shopping_cart_item": {
        "shopping_cart_type": "ShoppingCart",
        "customer_id": customerId,
        "product_id": productId,
      }
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      CustomFlashWidget.showFlashMessage(
          message: 'Moved to Cart', type: FlashType.success);
    } else {
      String errorMessage = 'Failed to move to cart.';
      var errorData = response.data;
      if (errorData['errors'] != null &&
          errorData['errors']['shopping cart item'] != null &&
          errorData['errors']['shopping cart item'].isNotEmpty) {
        errorMessage = errorData['errors']['shopping cart item'][0];
      }
      CustomFlashWidget.showFlashMessage(message: errorMessage);
    }
  }
}
