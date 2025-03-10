  import 'package:flutter/material.dart';
import 'package:nop_commerce/app/utils/color_helper.dart';
import 'package:nop_commerce/app/utils/extensions.dart';
import 'package:nop_commerce/app/utils/widgets/edit_button.dart';

class ContactInformationWidget extends StatelessWidget {
  const ContactInformationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xffF9F9F9),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Contact Information',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                ),
                5.SpaceX,
                const Text(
                  '+84932000000',
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 10),
                ),
                 const Text(
                  'amandamorgan@example.com',
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 10),
                ),
              ],
            ),
          ),
         EditButton()
        ],
      ),
    );
  }
}