import 'package:flutter/material.dart';
import 'package:nop_commerce/app/utils/color_helper.dart';
import 'package:nop_commerce/app/utils/extensions.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  final String? label;
  final String? hintText;
  final bool? readOnly;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final Widget? suffixIcon;

  const CustomTextField({
    Key? key,
    required this.controller,
    this.obscureText = false,
    this.label,
    this.hintText,
    this.readOnly,
    this.keyboardType,
    this.onChanged,
    this.onTap,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Text(
            label ?? "",
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        1.SpaceX,
        TextField(
          readOnly: readOnly ?? false,
          onTap: onTap,
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          onChanged: onChanged,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xffF1F4FE),
            hintText: hintText ?? "",
            hintStyle: const TextStyle(
              color: ColorHelper.hintColor,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            suffixIcon: suffixIcon,
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
