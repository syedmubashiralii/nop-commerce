import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SubTitle extends StatelessWidget {
  final String text;
  const SubTitle({super.key,required this.text});

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}


class AppBarWidget extends StatelessWidget {
  final String text;
  const AppBarWidget({super.key,required this.text});

  @override
  Widget build(BuildContext context) {
    return   Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: TextStyle(
              color: Colors.black, fontSize: 28, fontWeight: FontWeight.w800),
        ),
      ],
    );
  }
}