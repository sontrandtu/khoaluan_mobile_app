import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../theme/color.dart';
import '../../../utils/dialog_utils.dart';


class BottomCallBar extends StatelessWidget {

  final String? phoneNumber;
  const BottomCallBar({
    Key? key,
    this.phoneNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: 72,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.35),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Liên hệ: ",
              style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  color: Colors.pink,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              phoneNumber ?? "",
              style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            InkWell(
              onTap: () {
                showDefaultDialog(
                  context,
                  title: "Gọi điện thoại",
                  content: "Bạn có muốn gọi tới số $phoneNumber",
                  onPressNo: () => Navigator.of(context).pop(),
                  onPressYes: (){
                    launch('tel:+$phoneNumber');
                    Navigator.of(context).pop();
                  },
                );
              },
              child: Container(
                width: 112,
                height: 60,
                decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(12)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Gọi ngay",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          ?.copyWith(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.call,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}