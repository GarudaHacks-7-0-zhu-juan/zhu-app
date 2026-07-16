import 'package:flutter/material.dart';

abstract final class AppSpacing {
  static const xxs = 2.0;
  static const xs = 4.0;
  static const sm = 8.0;
  static const md = 12.0;
  static const lg = 16.0;
  static const xl = 24.0;
  static const xxl = 32.0;
  static const xxxl = 48.0;

  static const screen = EdgeInsets.symmetric(horizontal: lg);
}

abstract final class AppRadius {
  static const small = Radius.circular(4);
  static const medium = Radius.circular(8);
  static const large = Radius.circular(12);
}

abstract final class AppMotion {
  static const fast = Duration(milliseconds: 150);
  static const normal = Duration(milliseconds: 250);
  static const slow = Duration(milliseconds: 420);
}
