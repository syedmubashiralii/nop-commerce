import 'package:flutter/material.dart';
import 'package:nop_commerce/app/utils/color_helper.dart';
import 'package:nop_commerce/app/utils/extensions.dart';

class CustomDropdownField<T> extends StatelessWidget {
  final T? value;
  final List<T> items;
  final String? label;
  final String? hintText;
  final void Function(T?)? onChanged;

  const CustomDropdownField({
    Key? key,
    required this.value,
    required this.items,
    this.label,
    this.hintText,
    this.onChanged,
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
                fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black),
          ),
        1.SpaceX,
        Container(
          decoration: BoxDecoration(
            color: const Color(0xffF1F4FE),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 2),
          child: DropdownButtonFormField<T>(
            value: value,
            items: items
                .map((item) => DropdownMenuItem<T>(
                      value: item,
                      child: Text(
                        item.toString(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ))
                .toList(),
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: hintText ?? "",
              hintStyle: const TextStyle(
                  color: ColorHelper.hintColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
              border: InputBorder.none,
            ),
            isExpanded: true,
            dropdownColor: Colors.white,
            icon: const Icon(Icons.keyboard_arrow_down),
          ),
        ),
      ],
    );
  }
}
