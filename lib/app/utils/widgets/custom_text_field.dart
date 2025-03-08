import 'package:flutter/material.dart';
import 'package:nop_commerce/app/utils/color_helper.dart';
import 'package:nop_commerce/app/utils/extensions.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  final String? label;
  final String? hintText;

  const CustomTextField({
    Key? key,
    required this.controller,
    this.obscureText = false,
    this.label ,
    this.hintText ,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(label!=null)
        Text(label??"",style: TextStyle(fontSize: 13,fontWeight: FontWeight.w600,color: Colors.black),),
        1.SpaceX,
        TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xffF1F4FE),
            hintText: hintText??"",
            hintStyle: TextStyle(color: ColorHelper.hintColor,fontSize: 16,fontWeight: FontWeight.w500),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
