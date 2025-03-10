import 'package:flutter/material.dart';
import 'package:nop_commerce/app/utils/color_helper.dart';

class EditButton extends StatelessWidget {
  VoidCallback? onTap;
   EditButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: onTap,
      child: const CircleAvatar(
                radius: 15,
                backgroundColor: ColorHelper.blueColor,
                child: Icon(
                  Icons.edit_sharp,
                  color: Colors.white,
                  size: 18,
                )),
    );
  }
}