import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nop_commerce/app/controllers/authentication_controller.dart';
import 'package:nop_commerce/app/models/country_model.dart';
import 'package:nop_commerce/app/models/customer_model.dart';
import 'package:nop_commerce/app/models/customer_roles_model.dart';
import 'package:nop_commerce/app/models/token_model.dart';
import 'package:nop_commerce/app/routes/app_pages.dart';
import 'package:nop_commerce/app/services/settings_services.dart';
import 'package:nop_commerce/app/utils/custom_flash_widget.dart';
import 'package:nop_commerce/app/utils/dialogs/loading_dialog.dart';
import 'package:nop_commerce/app/utils/requests.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingsController extends GetxController {
  final AuthenticationController authenticationController = Get.find();
  Rxn<CustomerModel> customer = Rxn<CustomerModel>();
  var hidePassword = true.obs;

  final firstNameController = TextEditingController();
  final userNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var selectedGender = 'Male'.obs;
  var isGuest = true.obs;
  var selectedDateOfBirth = ''.obs;

  final Rx<PackageInfo?> packageInfo = Rx<PackageInfo?>(null);
  final RxString formattedDate = ''.obs;
  final RxList<CountryModel> countryList = <CountryModel>[].obs;

  final RxInt selectedLanguageID = 5000.obs;
  final RxString selectedLanguage = 'EN'.obs;
  final RxString selectedCurrency = 'USD'.obs;
  final RxInt selectedCurrencyID = 1000.obs;
  final RxString selectedSize = 'UK'.obs;
  final RxString selectedCountry = ''.obs;
  final RxInt selectedCountryID = 5000.obs;
  List<String> sizes = ['US', 'EU', 'UK'];

  var customerRoles = <CustomerRole>[].obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await _initializeSettings();
  }

  Future<void> _initializeSettings() async {
    _initPackageInfo();
    fetchCustomerRoles();
    fetchAllCountries();
    await fetchCurrentCustomer();
    
    
    if (customer.value?.currencyId != null) {
      selectedCurrencyID.value = customer.value?.currencyId ?? 1000;
      selectedCurrency.value = authenticationController.stores[0].currencies
          .where((currency) => currency.id == customer.value?.currencyId)
          .first
          .currencyCode;
    }
    if (customer.value?.shippingAddress?.countryId != null) {
      selectedCountryID.value = customer.value?.shippingAddress?.countryId ?? 1000;
      selectedCountry.value = countryList
          .where((country) => country.id == selectedCountryID.value)
          .first
          .name;
    }
    if (customer.value?.languageId != null) {
      selectedLanguageID.value = customer.value?.languageId ?? 5000;
      selectedLanguage.value = authenticationController.stores[0].languages
          .where((lang) => lang.id == customer.value?.languageId)
          .first
          .name;
    }
  }

  Future<void> _initPackageInfo() async {
    try {
      final info = await PackageInfo.fromPlatform();
      packageInfo.value = info;
      formattedDate.value = DateFormat('MMMM, yyyy').format(DateTime.now());
    } catch (e) {
      log('Failed to load package info: $e');
    }
  }

  Future<void> fetchAllCountries() async {
    try {
      final response = await Requests.getDio().get('countries');
      if (response.statusCode == 200) {
        countryList.value =
            CountryModel.listFromJson(response.data['countries']);
      }
    } catch (e) {
      log('Error fetching countries: $e');
    }
  }

  Future<void> fetchCurrentCustomer() async {
    try {
      CustomerModel? customerData = await SettingsServices().fetchCustomer();
      if (customerData != null) {
        customer.value = customerData;

        firstNameController.text = customer.value?.firstName ?? '';
        userNameController.text = customer.value?.userName ?? '';
        lastNameController.text = customer.value?.lastName ?? '';
        emailController.text = customer.value?.email ?? '';
        selectedGender.value = customer.value?.gender ?? 'Male';
        selectedDateOfBirth.value = customer.value?.dateOfBirth != null
            ? DateFormat('yyyy-MM-dd').format(customer.value!.dateOfBirth!)
            : '';
      }
    } catch (e) {
      log('Error fetching customer data: $e');
    }
  }

  Future<void> fetchCustomerRoles() async {
    final roles = await SettingsServices().getCustomerRoles();
    customerRoles.assignAll(roles);
  }

  Future<void> setCustomerData(bool toCheckPassword) async {
    final firstName = firstNameController.text.trim();
    final lastName = lastNameController.text.trim();
    final email = emailController.text.trim();
    final username = userNameController.text.trim();
    final dob = selectedDateOfBirth.value;
    final password = passwordController.text.trim();

    if (_validateInputs(
        firstName, lastName, email, dob, username, password, toCheckPassword)) {


      try {
        final customerData = {
          "customer_guid": Requests.box.read('customer_guid'),
          "username": username,
          "first_name": firstName,
          "last_name": lastName,
          "email": email,
          "registered_in_store_id": 1,
          "subscribed_to_newsletter": false,
          "vat_number": null,
          "vat_number_status_id": 0,
          "eu_cookie_law_accepted": null,
          "company": null,
          "role_ids": [3],
          "id": Requests.box.read('customer_id'),
          "gender": selectedGender.value,
          "date_of_birth": dob
        };

        if (toCheckPassword) {
          customerData["password"] = password;
        }
        await SettingsServices().updateCustomer(payload: {
          "customer": customerData,
        });
        await fetchCurrentCustomer();
      } catch (e) {
        log('Error updating customer data: $e');
        CustomFlashWidget.showFlashMessage(message: "Failed to update profile");
      }
    }
  }

  Future<void> loginUser() async {
    final email = emailController.text.trim();
    final password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "Email and password are required");
      return;
    }
    final emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
    if (!emailRegex.hasMatch(email)) {
      CustomFlashWidget.showFlashMessage(
          message: "Please enter a valid email address");
      return;
    }
    if (!(Get.isDialogOpen ?? false)) {
      Get.dialog(const LoadingDialog());
    }
    TokenModel? tokenModel = await Requests.requestNewToken(
        isGuest: false, username: email, password: password);
    print(tokenModel?.username ?? "");
    if ((Get.isDialogOpen ?? false)) {
      Get.back();
    }
    if (tokenModel != null &&
        tokenModel?.username != "" &&
        tokenModel?.username != null) {
      CustomFlashWidget.showFlashMessage(
          message: "Login Succesfull!", type: FlashType.success);
      Get.offAllNamed(Routes.SPLASH);
    } else {
      CustomFlashWidget.showFlashMessage(
          message: "Please check your credentials and try again");
    }
  }

  Future<void> logOutUser() async {
    await authenticationController.clearDataAndLogout();
    clearFields();
    CustomFlashWidget.showFlashMessage(
        message: "User Logout Successfully", type: FlashType.success);
    Get.offAllNamed(Routes.SPLASH);
  }

  void clearFields() {
    customer.value = CustomerModel();
  }

  Future<void> updateCustomerLanguage() async {
    if (selectedLanguage.value == '') {
      CustomFlashWidget.showFlashMessage(message: "Please select a language");
      return;
    }

    try {
      await SettingsServices().updateCustomer(payload: {
        "customer": {
          "customer_guid": Requests.box.read('customer_guid'),
          "language_id": selectedLanguageID.value,
        }
      });
      await fetchCurrentCustomer();
    } catch (e) {
      log('Error updating customer data: $e');
      CustomFlashWidget.showFlashMessage(message: "Failed to update profile");
    }
  }

  Future<void> updateCustomerCurrency() async {
    if (selectedCurrency.value == '') {
      CustomFlashWidget.showFlashMessage(message: "Please select a currency");
      return;
    }

    try {
      await SettingsServices().updateCustomer(payload: {
        "customer": {
          "customer_guid": Requests.box.read('customer_guid'),
          "currency_id": selectedCurrencyID.value,
        }
      });
      await fetchCurrentCustomer();
    } catch (e) {
      log('Error updating customer data: $e');
      CustomFlashWidget.showFlashMessage(message: "Failed to update profile");
    }
  }

  Future<void> setShippingAddress(Map payload) async {
    try {
      bool response =
          await SettingsServices().setShippingAddress(payload: payload);
      if (response == true) {
        await fetchCurrentCustomer();
      }
    } catch (e) {
      log('Error updating shipping address: $e');
    
    }
  }

  bool _validateInputs(String firstName, String lastName, String email,
      String dob, String username, String password, bool toCheckPassword) {
    if (firstName.isEmpty) {
      CustomFlashWidget.showFlashMessage(message: "First name is required");
      return false;
    }
    if (lastName.isEmpty) {
      CustomFlashWidget.showFlashMessage(message: "Last name is required");
      return false;
    }
    if (email.isEmpty) {
      CustomFlashWidget.showFlashMessage(message: "Email is required");
      return false;
    }
    final emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
    if (!emailRegex.hasMatch(email)) {
      CustomFlashWidget.showFlashMessage(
          message: "Please enter a valid email address");
      return false;
    }

    if (dob.isEmpty) {
      CustomFlashWidget.showFlashMessage(message: "Date of birth is required");
      return false;
    }

    if (username.isEmpty) {
      CustomFlashWidget.showFlashMessage(message: "Username is required");
      return false;
    }

    if (toCheckPassword) {
      if (password.isEmpty) {
        CustomFlashWidget.showFlashMessage(message: "Password is required");
        return false;
      }

      final passwordRegex =
          RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#\$&*~]).{8,}$');
      if (!passwordRegex.hasMatch(password)) {
        CustomFlashWidget.showFlashMessage(
            message:
                "Password must be at least 8 characters and include uppercase, lowercase, and a special character");
        return false;
      }
    }
    return true;
  }
}
