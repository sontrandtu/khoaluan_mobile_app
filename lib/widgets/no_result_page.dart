import 'package:flutter/material.dart';
import 'package:khoaluan_mobile_app/theme/color.dart';

class NoResultPage extends StatelessWidget {
  const NoResultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.description_outlined, size: 200, color: Colors.grey),
            Text(
                'Dữ liệu đang được cập nhật!',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  color: AppColors.textBlack,
                  fontSize: 16
                ))
          ],
        )
    );
  }
}