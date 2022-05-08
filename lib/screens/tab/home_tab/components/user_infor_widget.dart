import 'package:flutter/material.dart';

import '../../../../model/user_model.dart';
import '../../../../widgets/custom_cached_network_image.dart';

class UserInfo extends StatelessWidget {
  final UserModel userInfo;
  final GestureTapCallback? addPostTap;

  const UserInfo({
    Key? key,
    required this.userInfo,
    this.addPostTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomNetworkImage(
          url: userInfo.avatarUrl,
          width: 60,
          height: 60,
          isCircle: true,
        ),
        const SizedBox(width: 16),
        Text(
          userInfo.name ?? '',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
        ),
        const Spacer(),
        GestureDetector(
          child: const Icon(Icons.post_add_outlined, size: 36, color: Colors.white),
          onTap: addPostTap,
        )
      ],
    );
  }
}