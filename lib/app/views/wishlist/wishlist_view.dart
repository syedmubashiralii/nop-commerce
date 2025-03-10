import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nop_commerce/app/controllers/wishlist_controller.dart';
import 'package:nop_commerce/app/utils/color_helper.dart';
import 'package:nop_commerce/app/utils/extensions.dart';
import 'package:nop_commerce/app/views/settings/widgets/common_widgets.dart';
import 'package:nop_commerce/app/views/wishlist/wishlist_item.dart';

class WishlistView extends StatelessWidget {
  WishlistView({super.key});

  WishlistController controller = Get.put(WishlistController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppBarWidget(
                text: 'Wishlist',
              ),
              7.SpaceX,
              recentlyViewed(),
              14.SpaceX,
              _recentlyViewedListiew(),
              20.SpaceX,
              Expanded(
                child: ListView.builder(
                  itemCount: 6,
                  itemBuilder: (context, index) => WishlistItem(index: index),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _recentlyViewedListiew() {
    return SizedBox(
      height: 55,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 12,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 4),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 5,
                  spreadRadius: 0,
                  offset: const Offset(0, 0),
                ),
              ],
              image: const DecorationImage(
                image: NetworkImage("https://i.pravatar.cc/150?img=5"),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget recentlyViewed() {
    return InkWell(
      onTap: () {},
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Recently viewed',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          CircleAvatar(
            radius: 15,
            backgroundColor: ColorHelper.blueColor,
            child: Icon(
              Icons.arrow_forward_sharp,
              color: Colors.white,
              size: 20,
            ),
          )
        ],
      ),
    );
  }
}
