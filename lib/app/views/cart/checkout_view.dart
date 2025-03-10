import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nop_commerce/app/controllers/cart_controller.dart';
import 'package:nop_commerce/app/utils/color_helper.dart';
import 'package:nop_commerce/app/utils/constants.dart';
import 'package:nop_commerce/app/utils/extensions.dart';
import 'package:nop_commerce/app/utils/widgets/custom_button.dart';
import 'package:nop_commerce/app/utils/widgets/custom_radio_button.dart';
import 'package:nop_commerce/app/utils/widgets/edit_button.dart';
import 'package:nop_commerce/app/views/cart/add_voucher_view.dart';
import 'package:nop_commerce/app/views/cart/widgets/contact_information_widget.dart';
import 'package:nop_commerce/app/views/cart/widgets/shipping_address_widget.dart';
import 'package:nop_commerce/app/views/settings/widgets/common_widgets.dart';

class CheckoutView extends StatelessWidget {
  CartController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _buildCheckoutBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AppBarWidget(
                  mainAxisAlignment: MainAxisAlignment.start,
                  text: 'Payment',
                ),
                11.SpaceX,
                const ShippingAddressWidget(),
                6.SpaceX,
                const ContactInformationWidget(),
                20.SpaceX,
                _itemsHeader(onAddVoucher: ()=>AddVoucherView().show()),
                15.SpaceX,
                _itemsList(),
                16.SpaceX,
                shippingOptionHeader(),
                10.SpaceX,
                shippingOptionsList(),
                6.SpaceX,
                shippingDateInfo(),
                20.SpaceX,
                paymentMethodHeader(),
                11.SpaceX,
                selectedPaymentMethod()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget selectedPaymentMethod() {
    return Container(
      height: 30,
      width: 90,
      padding: const EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
          color: const Color(0xffE5EBFC),
          borderRadius: BorderRadius.circular(18)),
      alignment: Alignment.center,
      child: const Text(
        'Card',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: ColorHelper.blueColor),
      ),
    );
  }

  Widget paymentMethodHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Payment Method',
          style: TextStyle(fontSize: 21, fontWeight: FontWeight.w700),
        ),
        EditButton()
      ],
    );
  }

  Widget shippingDateInfo() {
    return const Text(
      'Delivered on or before Thursday, 23 April 2020',
      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
    );
  }

  Widget shippingOptionsList() {
    return Column(
      children: controller.shippingOptions.map((data) {
        return Obx(() {
          bool isSelected =
              data['name'] == controller.selectedShippingMethod.value;
          return GestureDetector(
            onTap: () => controller.selectedShippingMethod.value = data['name'],
            child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xffE5EBFC)
                    : const Color(0xffF9F9F9),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  CustomRadioButton(
                    isSelected: isSelected,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    data['name'] ?? "Standard",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 72,
                    height: 26,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color:
                          isSelected ? Colors.white : const Color(0xffF5F8FF),
                    ),
                    child: Text(
                      data['deliveryTime'],
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: ColorHelper.blueColor,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    data['price'] ?? 'FREE',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
      }).toList(),
    );
  }

  Widget shippingOptionHeader() {
    return const Text(
      'Shipping Options',
      style: TextStyle(fontSize: 21, fontWeight: FontWeight.w700),
    );
  }

  Widget _itemsList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 2,
      itemBuilder: (context, index) {
        return _itemContainer();
      },
    );
  }

  Widget _itemContainer() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          _itemAvatar(),
          9.SpaceY,
          const Expanded(
            child: Text(
              'Lorem ipsum dolor sit amet consectetur.',
              maxLines: 2,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  fontFamily: nunitoSans),
            ),
          ),
          9.SpaceY,
          const Text(
            '\$17,00',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
          )
        ],
      ),
    );
  }

  Widget _itemAvatar() {
    return Stack(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 4),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 5,
                spreadRadius: 0,
                offset: const Offset(0, 0),
              ),
            ],
            image: const DecorationImage(
              image: NetworkImage("https://i.pravatar.cc/150?img=5"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 2,
          right: 0,
          child: Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ColorHelper.lightContainer,
              border: Border.all(color: Colors.white, width: 2),
            ),
            alignment: Alignment.center,
            child: const Text(
              "1",
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ],
    );
  }

  Widget _itemsHeader({required VoidCallback onAddVoucher}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Text(
              'Items',
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.w700),
            ),
            8.SpaceY,
            Container(
              margin: const EdgeInsets.only(left: 7),
              height: 30,
              width: 30,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                  color: ColorHelper.lightContainer, shape: BoxShape.circle),
              child: const Text(
                '2',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
              ),
            ),
          ],
        ),
        InkWell(
          onTap: onAddVoucher,
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: ColorHelper.blueColor, width: 1),
                borderRadius: BorderRadius.circular(11)),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 22),
            child: const Text(
              'Add Voucher',
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: ColorHelper.blueColor,
                  fontFamily: nunitoSans),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildCheckoutBar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: const BoxDecoration(
        color: Color(0xffF5F5F5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Total \$34.00',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
          ),
          SizedBox(
              height: 40,
              width: 128,
              child: CustomButton(
                buttonText: 'Pay',
                buttonColor: ColorHelper.buttonBlack,
              )),
        ],
      ),
    );
  }
}
