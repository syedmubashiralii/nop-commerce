import 'package:get/get.dart';

class CartController  extends GetxController{

  RxString selectedShippingMethod='Standard'.obs;

  RxList shippingOptions=[
    {
      'name': 'Standard',
      'deliveryTime':'5-7 days',
      'price':'FREE'
    },
    {
      'name': 'Express',
      'deliveryTime':'1-2 days',
      'price':'\$12,00'
    }
  ].obs;
}