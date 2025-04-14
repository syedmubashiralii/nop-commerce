import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nop_commerce/app/utils/color_helper.dart';

class CustomRadioButton extends StatelessWidget {
  final bool isSelected;
  const CustomRadioButton({super.key, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white,
              width: 2.5,
            ),
            color: isSelected ? ColorHelper.blueColor : Color(0xffEFEFEF)),
        child:
            isSelected ? SvgPicture.asset('assets/Icons/ic-check.svg') : null);
  }
}
