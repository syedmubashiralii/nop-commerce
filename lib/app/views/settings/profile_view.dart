import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nop_commerce/app/utils/extensions.dart';
import 'package:nop_commerce/app/views/settings/widgets/common_widgets.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBarWidget(text: 'Settings',),
              7.SpaceX,
              SubTitle(text: 'Your Profile'),
              18.SpaceX,
              

              
            ],
          ),
        ),
      )),
    );
  }


}