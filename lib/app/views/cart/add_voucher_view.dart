import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nop_commerce/app/utils/color_helper.dart';
import 'package:nop_commerce/app/utils/extensions.dart';
import 'package:nop_commerce/app/utils/widgets/custom_button.dart';

class AddVoucherView extends StatelessWidget {
  const AddVoucherView({super.key});

  void show() {
    showModalBottomSheet(
      context: navigator!.context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      constraints: BoxConstraints(maxHeight: Get.height * .5),
      builder: (context) {
        return this;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 80,
              decoration: const BoxDecoration(
                color: Color(0xffF8FAFF),
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Text(
                "Active Vouchers",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  // Voucher List
                  _buildVoucherCard(
                    title: "First Purchase",
                    subtitle: "5% off for your next order",
                    validUntil: "5.16.20",
                  ),
                  const SizedBox(height: 15),
                  _buildVoucherCard(
                    title: "Gift From Customer Care",
                    subtitle: "15% off your next purchase",
                    validUntil: "6.20.20",
                  ),
                  20.SpaceX
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildVoucherCard({
    required String title,
    required String subtitle,
    required String validUntil,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ColorHelper.blueColor, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          6.SpaceX,
          Padding(
            padding: const EdgeInsets.only(left: 19, right: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Voucher",
                  style: TextStyle(
                      color: ColorHelper.blueColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 18),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xffFFEBEB),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    "Valid Until $validUntil",
                    style: const TextStyle(
                        fontSize: 11,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
          3.SpaceX,
          const DottedLine(
            dashColor: ColorHelper.blueColor,
          ),
          20.SpaceX,
          Padding(
            padding: const EdgeInsets.only(left: 19, right: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.card_giftcard,
                            color: ColorHelper.blueColor),
                        const SizedBox(width: 6),
                        Text(
                          title,
                          style: const TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 17),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(
                    width: 79,
                    height: 26,
                    child: CustomButton(
                      buttonText: 'Apply',
                      textStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                      padding: EdgeInsets.zero,
                    ))
              ],
            ),
          ),
          10.SpaceX,
        ],
      ),
    );
  }
}

