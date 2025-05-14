import 'package:get/get.dart';
import 'package:nop_commerce/app/services/order_services.dart';

class OrdersController extends GetxController {
  OrderServices orderServices = OrderServices();

  void createOrder({required List orderItems}) async {
    try {
      var response = await orderServices.createOrder(orderItems,0);
      if (response != null) {
        print("Order created successfully: $response");
      } else {
        print("Failed to create order");
      }
    } catch (e) {
      print("Error creating order: $e");
    }
  }
}
