import 'package:flutter/widgets.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

abstract class LoadMoreState<T extends StatefulWidget> extends State<T> {
  final RefreshController refreshController = RefreshController(initialRefresh: false);
  final ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    scrollController.dispose();
    refreshController.dispose();
    super.dispose();
  }
}
