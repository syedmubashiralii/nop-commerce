import 'dart:developer';

import 'package:flash/flash.dart';
import 'package:nop_commerce/app/models/customer_model.dart';
import 'package:nop_commerce/app/models/customer_roles_model.dart';
import 'package:nop_commerce/app/utils/custom_flash_widget.dart';
import 'package:nop_commerce/app/utils/requests.dart';

class SettingsServices {
  // Future<void> createCustomer({required Map payload}) async {
  //   var customer_guid = Requests.box.read('customer_guid');
  //   print(customer_guid);
  //   print('access token ');
  //   var request = await Requests.getDio().post('customers', data: payload);
  //   print(request.toString());
  // }

  Future<void> updateCustomer({required Map payload}) async {
    print(payload.toString());
    var customerId = Requests.box.read('customer_id');

    var request =
        await Requests.getDio().put('customers/$customerId', data: payload);
    print(request.toString());
  }

  Future<bool> setShippingAddress({required Map payload}) async {
    try {
      var customerId = Requests.box.read('customer_id');

      var request = await Requests.getDio()
          .post('customers/$customerId/shippingaddress', data: payload);
      if (request.statusCode == 200) {
        return true;
      } else {
        CustomFlashWidget.showFlashMessage(
            message: request.data['errors']['internal_server_error'] ??
                "Something went wrong, please contact support");
        return false;
      }
    } catch (e) {
        CustomFlashWidget.showFlashMessage(
          message: "Failed to update shipping address, please contact support");
      return false;
    }
  }

  Future<List<CustomerRole>> getCustomerRoles() async {
    var request = await Requests.getDio().get('customer_roles');
    print("get customer role ${request.data}");
    final data = request.data['customer_roles'] as List;

    return data.map((e) => CustomerRole.fromJson(e)).toList();
  }

  Future<CustomerModel?> fetchCustomer() async {
    try {
      final customerId = Requests.box.read('customer_id');
      final response = await Requests.getDio().get('customers/$customerId');
      if (response.statusCode == 200 && response.data['customers'] != null) {
        final customerData = response.data['customers'][0];
        log('Customer fetched: ${customerData}');
        return CustomerModel.fromJson(customerData);
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }
}
