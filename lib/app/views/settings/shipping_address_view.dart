import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nop_commerce/app/controllers/settings_controller.dart';
import 'package:nop_commerce/app/utils/color_helper.dart';
import 'package:nop_commerce/app/utils/extensions.dart';
import 'package:nop_commerce/app/utils/widgets/custom_button.dart';
import 'package:nop_commerce/app/utils/widgets/custom_text_field.dart';
import 'package:nop_commerce/app/views/settings/country_list_view.dart';
import 'package:nop_commerce/app/views/settings/widgets/common_widgets.dart';

class ShippingAddressView extends StatefulWidget {
  const ShippingAddressView({super.key});

  @override
  State<ShippingAddressView> createState() => _ShippingAddressViewState();
}

class _ShippingAddressViewState extends State<ShippingAddressView> {
  final controller = Get.put<SettingsController>(SettingsController());

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController companyController = TextEditingController();
  final TextEditingController address1Controller = TextEditingController();
  final TextEditingController address2Controller = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController zipCodeController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController faxController = TextEditingController();

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 10), () {
      final shipping = controller.customer.value?.shippingAddress;
      if (shipping == null) {
      emailController.text = controller.customer.value?.email ?? '';
      firstNameController.text = controller.customer.value?.firstName ?? '';
      lastNameController.text = controller.customer.value?.lastName ?? '';
      }

      if (shipping != null) {
        firstNameController.text = shipping.firstName ?? '';
        lastNameController.text = shipping.lastName ?? '';
        emailController.text = shipping.email ?? '';
        companyController.text = shipping.company ?? '';
        address1Controller.text = shipping.address1 ?? '';
        address2Controller.text = shipping.address2 ?? '';
        cityController.text = shipping.city ?? '';
        zipCodeController.text = shipping.zipPostalCode ?? '';
        phoneController.text = shipping.phoneNumber ?? '';
        faxController.text = shipping.faxNumber ?? '';
        controller.selectedCountryID.value = shipping.countryId ?? 1000;
        controller.selectedCountry.value = controller.countryList
            .where(
                (country) => country.id == controller.selectedCountryID.value)
            .first
            .name;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: ListView(
            children: [
              const AppBarWidget(text: 'Settings'),
              7.SpaceX,
              const SubTitle(text: 'Shipping Address'),
              25.SpaceX,
              const Text('Country',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
              2.SpaceX,
              _chooseCountry(),
              23.SpaceX,
              CustomTextField(
                  controller: firstNameController,
                  label: 'First Name',
                  hintText: 'Required'),
              10.SpaceX,
              CustomTextField(
                  controller: lastNameController,
                  label: 'Last Name',
                  hintText: 'Required'),
              10.SpaceX,
              CustomTextField(
                  controller: emailController,
                  label: 'Email',
                  hintText: 'Required'),
              10.SpaceX,
              CustomTextField(
                  controller: companyController,
                  label: 'Company (Optional)',
                  hintText: 'Optional'),
              10.SpaceX,
              CustomTextField(
                  controller: address1Controller,
                  label: 'Address 1',
                  hintText: 'Required'),
              10.SpaceX,
              CustomTextField(
                  controller: address2Controller,
                  label: 'Address 2 (Optional)',
                  hintText: 'Optional'),
              10.SpaceX,
              CustomTextField(
                  controller: cityController,
                  label: 'City',
                  hintText: 'Required'),
              10.SpaceX,
              CustomTextField(
                  controller: zipCodeController,
                  label: 'Zip/Postal Code',
                  hintText: 'Required'),
              10.SpaceX,
              CustomTextField(
                  controller: phoneController,
                  label: 'Phone Number',
                  hintText: 'Required'),
              10.SpaceX,
              CustomTextField(
                  controller: faxController,
                  label: 'Fax Number (Optional)',
                  hintText: 'Optional'),
              20.SpaceX,
              CustomButton(
                buttonText: 'Save Changes',
                onTap: _onSavePressed,
              ),
              20.SpaceX,
            ],
          ),
        ),
      ),
    );
  }

  void _onSavePressed() {
    if (firstNameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        emailController.text.isEmpty ||
        address1Controller.text.isEmpty ||
        cityController.text.isEmpty ||
        zipCodeController.text.isEmpty ||
        phoneController.text.isEmpty ||
        controller.selectedCountryID.value == 0) {
      Get.snackbar(
        'Validation Error',
        'Please fill all required fields',
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    if (controller.selectedCountryID.value == 5000) {
      Get.snackbar(
        'Validation Error',
        'Please select country',
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    final payload = {
      "first_name": firstNameController.text,
      "last_name": lastNameController.text,
      "email": emailController.text,
      "company": companyController.text,
      "country_id": controller.selectedCountryID.value,
      "country": controller.selectedCountry.value,
      "city": cityController.text,
      "address1": address1Controller.text,
      "address2": address2Controller.text,
      "zip_postal_code": zipCodeController.text,
      "phone_number": phoneController.text,
      "fax_number": faxController.text,
    };

    controller.setShippingAddress(payload);
  }

  Widget _chooseCountry() {
    return InkWell(
      onTap: () {
        Get.to(() => CountryListView(
              shouldUpdate: false,
            ));
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Obx(() {
            return Text(
              controller.selectedCountry.value.isEmpty
                  ? 'Choose your country'
                  : controller.selectedCountry.value,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            );
          }),
          const CircleAvatar(
            radius: 15,
            backgroundColor: ColorHelper.blueColor,
            child: Icon(
              Icons.arrow_forward_sharp,
              color: Colors.white,
              size: 20,
            ),
          )
        ],
      ),
    );
  }
}
