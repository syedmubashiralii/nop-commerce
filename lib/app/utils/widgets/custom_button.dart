import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:nop_commerce/app/utils/color_helper.dart';

class CustomButton extends StatelessWidget {
  String buttonText;
  CustomButton({super.key, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      padding: EdgeInsets.symmetric(vertical: 9),
      decoration: BoxDecoration(
        color: ColorHelper.blueColor,
        borderRadius: BorderRadius.circular(9),

      ),
      alignment: Alignment.center,
      child: Text(buttonText,style: TextStyle(
          fontSize: 16,fontWeight: FontWeight.w300,
          color: Colors.white

      ),),
    );
  }
}