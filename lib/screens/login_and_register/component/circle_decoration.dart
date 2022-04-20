import 'package:flutter/material.dart';

import '../../../theme/color.dart';

class CircleDecoration extends StatelessWidget {
  final double? radius;
  final double? top;
  final double? bottom;
  final double? left;
  final double? right;
  const CircleDecoration({
    Key? key,
    required this.radius,
    this.top,
    this.bottom,
    this.left,
    this.right,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: bottom,
      left: left,
      right: right,
      top: top,
      child: Container(
        height: radius,
        width: radius,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.primaryColor,
        ),
      ),
    );
  }
}
