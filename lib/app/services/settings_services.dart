import 'package:nop_commerce/app/utils/requests.dart';

class SettingsServices {
  Future<void> createCustomer({required Map payload}) async {
    var customer_guid = Requests.box.read('customer_guid');
    print(customer_guid);

    print('access token ');
    var request = await Requests.getDio().post('customers', data: payload);
    print(request.toString());
  }
}
