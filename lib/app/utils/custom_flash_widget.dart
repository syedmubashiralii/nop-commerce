import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nop_commerce/app/utils/color_helper.dart';
import 'package:nop_commerce/app/utils/extensions.dart';

enum FlashType { info, success, warning, error, none }

class FlashAction {
  final String label;
  final VoidCallback? onPressed;
  final Color? textColor;

  FlashAction({
    required this.label,
    this.onPressed,
    this.textColor,
  });
}

class CustomFlashWidget {
  static void showFlashMessage({

    List<FlashAction>? actions,
    required String message,
    FlashType type = FlashType.error,
    Color backgroundColor = ColorHelper.white,
    Icon? icon,
    FlashPosition position = FlashPosition.top,
    EdgeInsets margin =
        const EdgeInsets.symmetric(vertical: 50, horizontal: 50),
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(2)),
    bool barrierDismissible = true,
    Duration duration = const Duration(seconds: 5),
  }) {


    Widget icon;

    switch (type) {
      case FlashType.success:
        icon = const CircleAvatar(
            radius: 12,
            backgroundColor: Colors.green,
            child: Icon(
              Icons.check,
              color: ColorHelper.white,
              size: 18,
            ));
        break;
      case FlashType.warning:
        icon = const CircleAvatar(
            radius: 12,
            backgroundColor: Colors.amberAccent,
            child: Icon(
              Icons.warning,
              color: ColorHelper.white,
              size: 18,
            ));
        break;
      case FlashType.error:
        icon = const CircleAvatar(
            radius: 12,
            backgroundColor: Colors.red,
            child: Icon(
              Icons.close,
              color: ColorHelper.white,
              size: 18,
            ));
        break;
      case FlashType.info:
        icon = const CircleAvatar(
            radius: 12,
            backgroundColor: Colors.indigo,
            child: Icon(
              Icons.info_outline_rounded,
              color: ColorHelper.white,
              size: 18,
            ));
      case FlashType.info:
      default:
        icon = const SizedBox();
    }
    showFlash<bool>(
      context: navigator!.context,
      barrierDismissible: barrierDismissible,
      duration: duration,
      builder: (context, controller) {
        return FlashBar(
          width: Get.width*.8,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
          behavior: FlashBehavior.floating,
          clipBehavior: Clip.antiAlias,
          margin: const EdgeInsets.symmetric(
            vertical: 70,),
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
          controller: controller,
          position: position,

          content: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              icon,
              8.SpaceY,
              Expanded(
                child: Text(message,
                    style: const TextStyle(
                        color: ColorHelper.blueColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400)),
              ),
              8.SpaceY,
              InkWell(
                onTap: () {
                  controller.dismiss(true);
                },
                child: const Icon(
                  Icons.close,
                  color: ColorHelper.blueColor,
                ),
              )
            ],
          ),
          elevation: 3,
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          actions: actions?.map(
            (action) {
              return TextButton(
                onPressed: action.onPressed == null
                    ? () {
                        controller.dismiss(true);
                      }
                    : () {
                        controller.dismiss(true);
                        action.onPressed!();
                      },
                child: Text(
                  action.label,
                  style: TextStyle(
                      color: action.textColor ?? ColorHelper.blueColor),
                ),
              );
            },
          ).toList(),
        );
      },
    );
  }
}