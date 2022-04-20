import 'package:flutter/material.dart';

import '../theme/color.dart';

class CoverLoading extends StatelessWidget {
  final Widget child;
  final bool showLoading;
  final bool isStack;
  final Color color;

  const CoverLoading(
      {Key? key,
      this.showLoading = false,
      required this.child,
      this.isStack = false,
      this.color = Colors.black12})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (isStack || !showLoading) Container(child: child),
        Visibility(
          visible: showLoading,
          child: Container(
            height: double.infinity,
            width: double.infinity,
            color: color,
            child: Center(
              child: Container(
                height: 40,
                width: 40,
                padding: const EdgeInsets.all(8),
                child: CircularProgressIndicator(
                  color: AppColors.primaryColor,
                  strokeWidth: 2,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
