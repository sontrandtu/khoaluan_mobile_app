import 'package:flutter/material.dart';
import 'package:khoaluan_mobile_app/model/post_model.dart';
import 'package:khoaluan_mobile_app/theme/color.dart';
import 'package:khoaluan_mobile_app/widgets/cover_loading.dart';
import 'package:khoaluan_mobile_app/widgets/custom_cached_network_image.dart';
import 'package:khoaluan_mobile_app/widgets/no_result_page.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'list_post_view_model.dart';

class ListPostPage extends StatefulWidget {
  const ListPostPage({Key? key}) : super(key: key);

  @override
  State<ListPostPage> createState() => _ListPostPageState();
}

class _ListPostPageState extends State<ListPostPage> {

  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: const DefaultAppBar(title: "Tìm trọ"),
      body: SafeArea(
        child: Consumer<ListPostViewModel>(
          builder: (context, viewModel, child) => SmartRefresher(
            onRefresh: (){
              viewModel.refreshData(
                needShowLoading: false,
                onLoadedCallback: () {
                  _refreshController.refreshCompleted();
                },
              );
            },
            onLoading: () {
              viewModel.loadMore(onLoadedCallback: () {
                _refreshController.loadComplete();
              });
            },
            enablePullUp: true,
            controller: _refreshController,
            scrollController: scrollController,
            child: CoverLoading(
              showLoading: viewModel.isLoading,
              child: viewModel.showEmptyLayout ? const NoResultPage() : ListView.separated(
                padding: const EdgeInsets.symmetric( horizontal: 12, vertical: 12),
                itemBuilder: (context, index) {
                  final PostModel post = viewModel.data[index];
                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.3),
                      gradient: LinearGradient(
                        colors: [
                          AppColors.primaryColor,
                          Colors.black54,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                      child: Row(
                        children: [
                          CustomNetworkImage(
                              url: post.imageUrl,
                              width: 100,
                              height: 100,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    post.title ?? "",
                                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                                        fontWeight: FontWeight.bold,
                                    ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  "${post.price ?? ""} VNĐ/tháng",
                                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: AppColors.primaryColor
                                  ),
                                ),
                                Text(
                                  post.address ?? "",
                                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade600,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                  );
                },
                separatorBuilder: (_, __) {
                  return const SizedBox(height: 12);
                },
                itemCount: viewModel.data.length,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
