import 'package:flutter/material.dart';
import 'package:nop_commerce/app/utils/color_helper.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 35,
        height: 35,
        child: CircularProgressIndicator(color: ColorHelper.blueColor,)
      ),
    );
  }
}
