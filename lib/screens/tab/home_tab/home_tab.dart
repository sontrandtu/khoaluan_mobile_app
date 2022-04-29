import 'package:flutter/material.dart';
import 'package:khoaluan_mobile_app/model/user_model.dart';
import 'package:khoaluan_mobile_app/screens/tab/home_tab/home_view_model.dart';
import 'package:khoaluan_mobile_app/theme/color.dart';
import 'package:khoaluan_mobile_app/utils/extensions/context_extension.dart';
import 'package:khoaluan_mobile_app/widgets/custom_cached_network_image.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<HomeViewModel>(
        builder: (context, viewModel, child) => Container(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UserInfo(
                  userInfo: viewModel.userModel,
                  addPostTap: () {},
                ),
                ItemNameAndSeeAll(
                  itemName: "Danh mục tìm kiếm",
                  seeAllTap: () {},
                ),
                ItemNameAndSeeAll(
                  itemName: "Xu hướng",
                  seeAllTap: () {},
                ),
                ItemNameAndSeeAll(
                  itemName: "Phòng nổi bật",
                  seeAllTap: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

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
          url: userInfo.image ?? '',
          width: 60,
          height: 60,
          isCircle: true,
        ),
        const SizedBox(width: 16),
        Text(
          userInfo.name ?? '',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        const Spacer(),
        GestureDetector(
          child: const Icon(Icons.post_add_outlined, size: 36),
          onTap: addPostTap,
        )
      ],
    );
  }
}

class ItemNameAndSeeAll extends StatelessWidget {
  final String? itemName;
  final GestureTapCallback? seeAllTap;

  const ItemNameAndSeeAll({
    Key? key,
    this.itemName,
    this.seeAllTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          itemName ?? '',
          style: context
              .textStyle(color: AppColors.textBlack)
              .copyWith(fontWeight: FontWeight.w700, fontSize: 16),
        ),
        GestureDetector(
          onTap: seeAllTap,
          child: Text(
            "Xem tất cả",
            style: context.textStyle(color: AppColors.primaryColor).copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
          ),
        ),
      ],
    );
  }
}
