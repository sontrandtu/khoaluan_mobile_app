import 'package:flutter/material.dart';
import 'package:khoaluan_mobile_app/page_routes.dart';
import 'package:khoaluan_mobile_app/screens/tab/my_post_tab/my_post_view_model.dart';
import 'package:khoaluan_mobile_app/theme/app_bar.dart';
import 'package:khoaluan_mobile_app/utils/extensions/context_extension.dart';
import 'package:khoaluan_mobile_app/widgets/cover_loading.dart';
import 'package:khoaluan_mobile_app/widgets/no_result_page.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:khoaluan_mobile_app/utils/extensions/string_extension.dart';

import '../../../theme/color.dart';
import '../../../widgets/custom_cached_network_image.dart';

class MyPostTab extends StatefulWidget {
  const MyPostTab({Key? key}) : super(key: key);

  @override
  State<MyPostTab> createState() => _MyPostTabState();
}

class _MyPostTabState extends State<MyPostTab> {

  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(title: "Bài viết của tôi", canBack: false,),
      body: Consumer<MyPostViewModel>(
        builder: (context, viewModel, child) =>  CoverLoading(
          showLoading: viewModel.isLoading,
          isStack: true,
          child: SmartRefresher(
            controller: _refreshController,
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
            child: (viewModel.myPostModel?.postData?.isEmpty ?? true) ? const NoResultPage(): ListView.separated(
              padding: const EdgeInsets.only(top: 20, bottom: 80),
              itemBuilder: (context, index) {
                final item = viewModel.myPostModel?.postData?[index];
                return GestureDetector(
                  onTap: (){
                    Navigator.of(context, rootNavigator: true).pushNamed(PageRoutes.postDetailsPage, arguments: item?.id);
                  },
                  child: Container(
                    height: 132,
                    padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
                    margin: const EdgeInsets.only(top: 5, bottom: 10, left: 10, right: 10),
                    decoration: BoxDecoration(
                      color: AppColors.textWhite,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(width: 1, color: Colors.grey.withOpacity(0.2)),
                    ),
                    child: Row(
                      children: [
                        CustomNetworkImage(
                          url: item?.imagePost?.imageUrl ?? '',
                          width: 100,
                          height: 100,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "${item?.price ?? ''} VNĐ/Người",
                                  style: TextStyle(
                                      color: AppColors.primaryColor,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                item?.title ?? '',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    ?.copyWith(fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                item?.address ?? '',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    ?.copyWith(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black54),
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
                return const SizedBox(height: 8);
              }, itemCount: viewModel.myPostModel?.postData?.length ?? 0 ,
            ),
          ),
        ),
      ),
    );
  }
}
