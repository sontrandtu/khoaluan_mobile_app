import 'package:flutter/material.dart';
import 'package:khoaluan_mobile_app/utils/extensions/context_extension.dart';

import '../../../../theme/color.dart';

class ItemNameAndSeeAll extends StatelessWidget {
  final String? itemName;
  final GestureTapCallback? seeAllTap;
  final bool canSeeAll;

  const ItemNameAndSeeAll({
    Key? key,
    this.itemName,
    this.seeAllTap,
    this.canSeeAll = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, top: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            itemName ?? '',
            style: context
                .textStyle(color: AppColors.textBlack)
                .copyWith(fontWeight: FontWeight.w700, fontSize: 16),
          ),
          canSeeAll ? GestureDetector(
            onTap: seeAllTap,
            child: Text(
              "Xem tất cả",
              style: context.textStyle(color: AppColors.primaryColor).copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
            ),
          ) : const SizedBox(),
        ],
      ),
    );
  }
}
