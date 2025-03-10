import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nop_commerce/app/utils/color_helper.dart';

class CartItem extends StatelessWidget {
  final int index;
  const CartItem({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 6,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    "assets/images/bag.png",
                    width: 105,
                    height: 105,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Positioned(
                bottom: 7,
                left: 7,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 17,
                  child: Icon(
                    CupertinoIcons.delete,
                    color: ColorHelper.lightPink,
                    size: 18,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Lorem ipsum dolor sit amet consectetur.",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Spacer(),
                const Text(
                  "Pink, Size M",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (index == 1) ...[
                      const Text("\$17,00",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.lineThrough,
                              decorationColor: ColorHelper.lightRed,
                              color: ColorHelper.lightRed)),
                      const SizedBox(width: 4),
                      const Text("\$12,00",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700)),
                    ] else
                      Text("\$${(index + 1) * 10 + 7},00",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700)),
                    Row(
                      children: [
                        _plusMinusButton(CupertinoIcons.minus),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xffE5EBFC),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text('2',
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
    ),
                         _plusMinusButton(CupertinoIcons.add),
                        
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _plusMinusButton(IconData icon) {
    return Container(
                          height: 30,
                          width: 30,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  width: 2, color: ColorHelper.blueColor)),
                          child: Icon(
                            icon,
                            color: ColorHelper.blueColor,
                            size: 20,
                          ),
                        );
  }
}
