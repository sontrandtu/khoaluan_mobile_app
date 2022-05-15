import 'package:flutter/material.dart';
import 'package:khoaluan_mobile_app/screens/list_post_page/list_post_page.dart';
import 'package:khoaluan_mobile_app/screens/list_post_page/list_post_view_model.dart';
import 'package:khoaluan_mobile_app/theme/app_bar.dart';
import 'package:provider/provider.dart';
import 'package:status_change/status_change.dart';

class  RoommatesTab extends StatefulWidget {
  const RoommatesTab({Key? key}) : super(key: key);

  @override
  State<RoommatesTab> createState() => _RoommatesTabState();
}

class _RoommatesTabState extends State<RoommatesTab> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => ListPostViewModel(
            postRepo: context.watch(),
          categoryId: 'js5uSLLOhKqkvmIEzNeU'
        ),
      child: const Scaffold(
        appBar: DefaultAppBar(title: "Tìm người ở ghép", canBack: false),
          body: ListPostPage(isSearch: false),
      ),
    );
  }
}
