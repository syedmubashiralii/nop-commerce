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
    final Map<String, dynamic> data =  <String, dynamic>{};
    if (shoppingCarts != null) {
      data['shopping_carts'] =
          shoppingCarts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ShoppingCarts {
  List<ProductAttribute>? productAttributes;
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
        productAttributes!.add(ProductAttribute.fromMap(v));
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
    final Map<String, dynamic> data =  <String, dynamic>{};
    if (productAttributes != null) {
      data['product_attributes'] =
          productAttributes!.map((v) => v.toJson()).toList();
    }
    data['customer_entered_price'] = customerEnteredPrice;
    data['quantity'] = quantity;
    data['rental_start_date_utc'] = rentalStartDateUtc;
    data['rental_end_date_utc'] = rentalEndDateUtc;
    data['created_on_utc'] = createdOnUtc;
    data['updated_on_utc'] = updatedOnUtc;
    data['shopping_cart_type'] = shoppingCartType;
    data['product_id'] = productId;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    data['customer_id'] = customerId;
    data['id'] = id;
    return data;
  }
}

class ProductAttribute {
  int id;
  String value;

  ProductAttribute({required this.id, required this.value});

  factory ProductAttribute.fromMap(Map<String, dynamic> map) {
    return ProductAttribute(
      id: map['id'],
      value: map['value'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'value': value,
    };
  }
}
