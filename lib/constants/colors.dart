import 'dart:ui';

import 'package:flutter/material.dart';

class ColorPallet{
  static final Color kNavyColor=Color(0xff190159);
  static final linearGradient = LinearGradient(
          colors: [
            Color(0xff2412C0),
            Color(0xff4910BC)
          ], 
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
  static final linearGradientTwo = LinearGradient(
          colors: [
            Color(0xff2412C0),
            Color(0xff4910BC).withOpacity(.7)
          ], 
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
}