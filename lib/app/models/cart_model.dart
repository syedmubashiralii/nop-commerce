import 'package:nop_commerce/app/models/product_model.dart';

class CartModel {
  List<ShoppingCarts>? shoppingCarts;

  CartModel({this.shoppingCarts});

  CartModel.fromJson(Map<String, dynamic> json) {
    if (json['shopping_carts'] != null) {
      shoppingCarts = <ShoppingCarts>[];
      json['shopping_carts'].forEach((v) {
        shoppingCarts!.add( ShoppingCarts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    if (this.shoppingCarts != null) {
      data['shopping_carts'] =
          this.shoppingCarts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ShoppingCarts {
  List? productAttributes;
  var customerEnteredPrice;
  int? quantity;
  var rentalStartDateUtc;
  var rentalEndDateUtc;
  String? createdOnUtc;
  String? updatedOnUtc;
  String? shoppingCartType;
  int? productId;
  Products? product;
  int? customerId;
  int? id;

  ShoppingCarts(
      {this.productAttributes,
      this.customerEnteredPrice,
      this.quantity,
      this.rentalStartDateUtc,
      this.rentalEndDateUtc,
      this.createdOnUtc,
      this.updatedOnUtc,
      this.shoppingCartType,
      this.productId,
      this.product,
      this.customerId,
      this.id});

  ShoppingCarts.fromJson(Map<String, dynamic> json) {
    if (json['product_attributes'] != null) {
      productAttributes = [];
      json['product_attributes'].forEach((v) {
        productAttributes!.add( '');
      });
    }
    customerEnteredPrice = json['customer_entered_price'];
    quantity = json['quantity'];
    rentalStartDateUtc = json['rental_start_date_utc'];
    rentalEndDateUtc = json['rental_end_date_utc'];
    createdOnUtc = json['created_on_utc'];
    updatedOnUtc = json['updated_on_utc'];
    shoppingCartType = json['shopping_cart_type'];
    productId = json['product_id'];
    product =
        json['product'] != null ?  Products.fromJson(json['product']) : null;
    customerId = json['customer_id'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    if (this.productAttributes != null) {
      data['product_attributes'] =
          this.productAttributes!.map((v) => v.toJson()).toList();
    }
    data['customer_entered_price'] = this.customerEnteredPrice;
    data['quantity'] = this.quantity;
    data['rental_start_date_utc'] = this.rentalStartDateUtc;
    data['rental_end_date_utc'] = this.rentalEndDateUtc;
    data['created_on_utc'] = this.createdOnUtc;
    data['updated_on_utc'] = this.updatedOnUtc;
    data['shopping_cart_type'] = this.shoppingCartType;
    data['product_id'] = this.productId;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    data['customer_id'] = this.customerId;
    data['id'] = this.id;
    return data;
  }
}

