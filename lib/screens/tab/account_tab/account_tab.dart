import 'package:flutter/material.dart';
import 'package:khoaluan_mobile_app/screens/tab/account_tab/account_view_model.dart';
import 'package:provider/provider.dart';

import '../../../page_routes.dart';
import '../../../preference/preference.dart';
import '../../../theme/color.dart';

class AccountTab extends StatefulWidget {
  const AccountTab({Key? key}) : super(key: key);

  @override
  State<AccountTab> createState() => _AccountTabState();
}

class _AccountTabState extends State<AccountTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TÀI KHOẢN"),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Consumer<AccountViewModel>(
          builder: (context, viewModel, child) => Center(
            child: SingleChildScrollView(
                child: Column(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage("assets/images/placeholder.png"),
                  radius: 40,
                ),
                const SizedBox(height: 32),
                ProfileItem(
                  head: Icons.manage_accounts_outlined,
                  title: "Thông tin tài khoản",
                  onTap: () {},
                  tail: Icons.arrow_forward_ios_outlined,
                ),
                const SizedBox(height: 16),
                ProfileItem(
                  head: Icons.list_alt_outlined,
                  title: "Bài đăng của tôi",
                  onTap: () {},
                  tail: Icons.arrow_forward_ios_outlined,
                ),
                const SizedBox(height: 16),
                ProfileItem(
                  head: Icons.settings_outlined,
                  title: "Cài đặt",
                  onTap: () {},
                  tail: Icons.arrow_forward_ios_outlined,
                ),
                const SizedBox(height: 16),
                ProfileItem(
                  head: Icons.shield_outlined,
                  title: "Điều khoản sử dụng",
                  onTap: () {},
                  tail: Icons.arrow_forward_ios_outlined,
                ),
                const SizedBox(height: 16),
                // CustomNetworkImage(url: url, width: width, height: height)
                ProfileItem(
                  head: Icons.logout_outlined,
                  title: "Đăng xuất",
                  onTap: () {
                    PreferenceManager.logOut();
                    Navigator.of(context, rootNavigator: true)
                        .pushNamedAndRemoveUntil(
                            PageRoutes.loginPage, (route) => false);
                  },
                )
              ],
            )),
          ),
        ),
      ),
    );
  }
}

class ProfileItem extends StatelessWidget {
  final IconData head;
  final IconData? tail;
  final String title;
  final VoidCallback onTap;

  const ProfileItem({
    Key? key,
    required this.head,
    required this.title,
    this.tail,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 52,
      child: ListTile(
        onTap: onTap,
        title: Text(title,
            style: const TextStyle(fontSize: 14, color: AppColors.textBlack)),
        leading: SizedBox(
          height: 38,
          width: 38,
          child: Card(
            color: AppColors.primaryColor.withOpacity(0.2),
            elevation: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Icon(head, color: AppColors.primaryColor, size: 18),
            ),
          ),
        ),
        trailing: Icon(tail, size: 10),
      ),
    );
  }
}
