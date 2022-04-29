import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:khoaluan_mobile_app/utils/extensions/context_extension.dart';
import 'package:khoaluan_mobile_app/utils/extensions/text_styles_extension.dart';

import '../../../../theme/color.dart';


class HeaderBox extends StatelessWidget {
  final String title;
  final String viewAllTitle;
  final GestureTapCallback? onTap;
  final int arguments;
  const HeaderBox(
      {Key? key,
        required this.title,
        this.viewAllTitle = '',
        this.arguments = 0,
        this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
      child: Row(
        children: [
          Text(
            title,
            style: context
                .textStyle(color: AppColors.textBlack)
                .size16
                .w700
                .fontQuicksand,
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          GestureDetector(
            child: Text(
              viewAllTitle,
              style: context
                  .textStyle(color: AppColors.textBlack)
                  .w400
                  .size12
                  .fontQuicksand,
              textAlign: TextAlign.center,
            ),
            onTap: onTap,
          )
        ],
      ),
    );
  }
}
