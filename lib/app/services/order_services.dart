import 'package:get/get.dart';
import 'package:nop_commerce/app/controllers/authentication_controller.dart';
import 'package:nop_commerce/app/utils/requests.dart';

class OrderServices {
  Future createOrder(var orderItems, double orderTotal) async {
    int customerId = Requests.box.read('customer_id') ?? 0;
    AuthenticationController authenticationController = Get.find();
    final nowUtc = DateTime.now().toUtc();
    var response = await Requests.getDio().post('orders', data: {
      "order": {
        "billing_address": {
          "first_name": "Syed Mubashir",
          "last_name": "Ali",
          "email": "smubashirali620@gmail.com",
          "country": "Pakistan",
          "state_province_id": 1,
          "city": "Islamabad",
          "address1": "25, Westeria Road, Dha",
          "address2": "45, Westeria Road, Dha",
          "zip_postal_code": "232323",
          "phone_number": "03105205275",
          "fax_number": "434343",
          "customer_attributes": "3",
          "created_on_utc": "",
          "province": "3",
          "id": "3"
        },
        "shipping_address": {
            "first_name": "Syed Mubashir",
          "last_name": "Ali",
          "email": "smubashirali620@gmail.com",
          "country": "Pakistan",
          "state_province_id": 1,
          "city": "Islamabad",
          "address1": "25, Westeria Road, Dha",
          "address2": "45, Westeria Road, Dha",
          "zip_postal_code": "232323",
          "phone_number": "03105205275",
          "fax_number": "434343",
          "customer_attributes": "3",
          "created_on_utc": "",
          "province": "3",
          "id": "3"
        },
        "order_items": orderItems,
        "order_status": "Processing",
        "payment_method_system_name":"NA",
         "shipping_rate_computation_method_system_name": "NA",
        "payment_status": "PartiallyRefunded",
        "shipping_status": "ShippingNotRequired",
        "customer_id": customerId,
        "shipping_method": "Express",
        "paid_date_utc": DateTime.now().toUtc().toIso8601String(),
        "customer_language_id":
            authenticationController.stores[0].defaultLanguageId,
        "order_discount": 0,
        "order_total": 1221,
        "customer_currency_code": "<string>",
        "checkout_attribute_1": 0,
        "store_id": authenticationController.stores[0].id,
      }
    });
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('Failed to create order');
    }
  }
}
