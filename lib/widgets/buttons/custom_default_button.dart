import 'package:flutter/material.dart';

import '../../theme/color.dart';

class CustomDefaultButton extends StatelessWidget {
  final String? title;
  final double? height; //height of button
  final double? padding;
  final GestureTapCallback? onTap; // horizontal padding of button
  const CustomDefaultButton({
    Key? key,
    this.title,
    this.height,
    this.padding,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height ?? 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: padding ?? 20),
          shadowColor: AppColors.primaryColor,
        ),
        onPressed: onTap,
        child: Text(
          title ?? 'Default',
          style: const TextStyle(
              color: AppColors.textBlack,
              fontFamily: 'RobotoSlab',
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
