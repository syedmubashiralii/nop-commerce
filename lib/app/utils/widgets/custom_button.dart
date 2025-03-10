import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nop_commerce/app/utils/color_helper.dart';

class CustomButton extends StatelessWidget {
  String buttonText;
  Color? buttonColor;
  VoidCallback? onTap;
  CustomButton({super.key, required this.buttonText,this.buttonColor,this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: Get.width,
        padding: const EdgeInsets.symmetric(vertical: 9),
        decoration: BoxDecoration(
          color:buttonColor?? ColorHelper.blueColor,
          borderRadius: BorderRadius.circular(9),
      
        ),
        alignment: Alignment.center,
        child: Text(buttonText,style: const TextStyle(
            fontSize: 16,fontWeight: FontWeight.w300,
            color: Colors.white
      
        ),),
      ),
    );
  }
}