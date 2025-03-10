
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nop_commerce/app/utils/color_helper.dart';

class WishlistItem extends StatelessWidget {
  final int index;
  const WishlistItem({super.key, required this.index});

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
                Row(
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
                  ],
                ),
                Spacer(),
                Row(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            _buildTag("Pink"),
                            const SizedBox(width: 6),
                            _buildTag("M"),
                          ],
                        ),
                      ),
                    ),
                    SvgPicture.asset('assets/images/add-to-cart.svg'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xffE5EBFC),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(text,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
    );
  }
}
