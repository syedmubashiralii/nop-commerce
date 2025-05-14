import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nop_commerce/app/controllers/cart_controller.dart';
import 'package:nop_commerce/app/controllers/orders_controller.dart';
import 'package:nop_commerce/app/utils/color_helper.dart';

class OrdersView extends StatelessWidget {
  OrdersView({super.key});

  OrdersController ordersController = Get.put(OrdersController());
  CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    cartController.createOrder();
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _profilePicture(),
                    ],
                  )
                ],
              )),
        ),
      ),
    );
  }

  Widget _profilePicture() {
    return Stack(
      children: [
        Container(
          width: 50,
          height: 50,
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
      ],
    );
  }
}
