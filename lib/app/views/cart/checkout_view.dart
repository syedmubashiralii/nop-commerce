import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nop_commerce/app/controllers/cart_controller.dart';
import 'package:nop_commerce/app/utils/color_helper.dart';
import 'package:nop_commerce/app/utils/extensions.dart';
import 'package:nop_commerce/app/utils/widgets/custom_button.dart';
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
                _itemsHeader(),
              ],
            ),
          ),
        ),
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
          top: 1,
          right: 1,
          child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ColorHelper.lightContainer,
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: Text("1",style: TextStyle(fontSize: 13,fontWeight: FontWeight.w700),),
          ),
        ),
      ],
    );
  }

  Widget _itemsHeader() {
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
        Container(
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
                fontFamily: 'NunitoSans'),
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
