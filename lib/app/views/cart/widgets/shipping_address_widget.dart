  import 'package:flutter/material.dart';
import 'package:nop_commerce/app/utils/extensions.dart';
import 'package:nop_commerce/app/utils/widgets/edit_button.dart';

class ShippingAddressWidget extends StatelessWidget {
  final VoidCallback? onEdit;
  const ShippingAddressWidget({super.key,this.onEdit});

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
                  'Shipping Address',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                ),
                5.SpaceX,
                const Text(
                  '26, Duong So 2, Thao Dien Ward, An Phu, District 2',
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 10),
                ),
              ],
            ),
          ),
          EditButton(onTap: onEdit,)
        ],
      ),
    );
  }
}