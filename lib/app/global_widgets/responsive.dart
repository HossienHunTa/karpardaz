import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Responsive extends StatelessWidget {
  const Responsive({
    super.key,
    required this.mobileBodyisPortrait,
    required this.tabletBodyisPortrait,
  });
  final Widget mobileBodyisPortrait;
  final Widget tabletBodyisPortrait;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (context.isPhone) {
        return mobileBodyisPortrait;
      } else {
        return tabletBodyisPortrait;
      }
    });
  }
}
