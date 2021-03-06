import 'package:flutter/material.dart';

import '../../theme/color.dart';

class CustomDefaultButton extends StatelessWidget {
  final String? title;
  final double? height; //height of button
  final double? padding; // horizontal padding of button
  final GestureTapCallback? onTap;
  const CustomDefaultButton({
    Key? key,
    this.title,
    this.height,
    this.padding,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: padding ?? 20),
      width: double.infinity,
      height: height ?? 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          shadowColor: AppColors.textButtonColor,
        ),
        onPressed: onTap,
        child: Text(
          title!.toUpperCase(),
          style: const TextStyle(
              color: AppColors.textButtonColor,
              fontFamily: 'RobotoSlab',
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
