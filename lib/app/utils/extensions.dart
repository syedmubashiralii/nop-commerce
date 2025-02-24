
import 'package:flutter/material.dart';

extension CustomSpacing on num {
  SizedBox get SpaceX {
    return SizedBox(height: toDouble());
  }

  SizedBox get SpaceY {
    return SizedBox(width: toDouble());
  }
}

String capitalizeFirstLetter(String input) {
  if (input.isEmpty) {
    return input;
  }
  return input[0].toUpperCase() + input.substring(1).toLowerCase();
}



extension RouterExtenstions on BuildContext {
  double get x => MediaQuery.of(this).size.width;
  double get y => MediaQuery.of(this).size.height;
}