import 'package:flutter/material.dart';

class ZephyrListTheme {
  const ZephyrListTheme({
    this.tilePadding,
    this.contentPadding,
    this.horizontalTitleGap = 16,
    this.minVerticalPadding = 8,
  });

  final EdgeInsetsGeometry? tilePadding;
  final EdgeInsetsGeometry? contentPadding;
  final double horizontalTitleGap;
  final double minVerticalPadding;
}
