import 'package:flutter/material.dart';
import 'package:khoaluan_mobile_app/page_routes.dart';
import 'package:khoaluan_mobile_app/screens/post_by_category/post_by_category_view_model.dart';
import 'package:khoaluan_mobile_app/theme/app_bar.dart';
import 'package:khoaluan_mobile_app/utils/extensions/context_extension.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../model/post_model.dart';
import '../../theme/color.dart';
import '../../widgets/cover_loading.dart';
import '../../widgets/custom_cached_network_image.dart';
import '../../widgets/no_result_page.dart';

class PostsByCategoryPage extends StatefulWidget {
  const PostsByCategoryPage({Key? key}) : super(key: key);

  @override
  State<PostsByCategoryPage> createState() => _PostsByCategoryPageState();
}

final RefreshController _refreshController = RefreshController(initialRefresh: false);
final ScrollController scrollController = ScrollController();

class _PostsByCategoryPageState extends State<PostsByCategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PostByCategoryViewModel>(
        builder: (context, viewModel, child) => Scaffold(
          appBar: DefaultAppBar(title: viewModel.category?.name,),
          body: SmartRefresher(
            onRefresh: (){
              viewModel.getData(
                  onLoadedCallback: (){
                    _refreshController.refreshCompleted(resetFooterState: true);
                  },
                  errorCallback: (error){
                    context.showMessage(error,type: MessageType.error);
                  }
              );
            },
            enablePullUp: true,
            controller: _refreshController,
            scrollController: scrollController,
            child: CoverLoading(
              showLoading: viewModel.isLoading,
              child: viewModel.posts.isEmpty ? const NoResultPage() : ListView.separated(
                padding: const EdgeInsets.symmetric( horizontal: 12, vertical: 12),
                itemBuilder: (context, index) {
                  final PostModel post = viewModel.posts[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(PageRoutes.postDetailsPage, arguments: post.id);
                    },
                    child: Container(
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
                    ),
                  );
                },
                separatorBuilder: (_, __) {
                  return const SizedBox(height: 12);
                },
                itemCount: viewModel.posts.length,
              ),
            ),
          ),
        ),
    );
  }
}
