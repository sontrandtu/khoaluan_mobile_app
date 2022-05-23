import 'package:flutter/material.dart';
import 'package:khoaluan_mobile_app/utils/dialog_utils.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../page_routes.dart';
import '../../theme/app_bar.dart';
import '../../theme/color.dart';
import '../../utils/extensions/context_extension.dart';
import '../../widgets/cover_loading.dart';
import '../../widgets/custom_cached_network_image.dart';
import '../../widgets/no_result_page.dart';
import 'list_my_post_view_model.dart';
import 'package:khoaluan_mobile_app/utils/extensions/string_extension.dart';

class ListMyPostPage extends StatefulWidget {
  const ListMyPostPage({Key? key}) : super(key: key);

  @override
  State<ListMyPostPage> createState() => _ListMyPostPageState();
}

class _ListMyPostPageState extends State<ListMyPostPage> {

  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(title: "Bài viết của tôi"),
      body: Consumer<ListMyPostViewModel>(
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
                    Navigator.of(context, rootNavigator: true).pushNamed(PageRoutes.updatePostPage, arguments: item).then((value) {
                      viewModel.getData(
                          onLoadedCallback: (){
                            _refreshController.refreshCompleted(resetFooterState: true);
                          },
                          errorCallback: (error){
                            context.showMessage(error,type: MessageType.error);
                          }
                      );
                    });
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
                          child: Row(
                            children: [
                              SizedBox(
                                width: 160,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${item?.price ?? ''} VNĐ/Người",
                                      style: TextStyle(
                                          color: AppColors.primaryColor,
                                          fontWeight: FontWeight.bold
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
                              const SizedBox(width: 10),
                              IconButton(
                                  onPressed: () {
                                    viewModel.postId = item?.id;
                                    showDefaultDialog(
                                        context,
                                        title: "Xoá bài viết",
                                        content: "Bạn có chắc chắn muốn xoá bài viết này?",
                                        onPressNo: (){
                                          Navigator.of(context).pop();
                                        },
                                        onPressYes: (){
                                          viewModel.deletePost(
                                            successCallback: (mes){
                                              context.showMessage(mes, type: MessageType.success);
                                              viewModel.getData(
                                                  onLoadedCallback: (){
                                                    _refreshController.refreshCompleted(resetFooterState: true);
                                                  },
                                                  errorCallback: (error){
                                                    context.showMessage(error,type: MessageType.error);
                                                  }
                                              ).then((value) => Navigator.of(context).pop());
                                            },
                                            errorCallback: (error){
                                              context.showMessage(error, type: MessageType.error);
                                            }
                                          );
                                        },
                                    );
                                  },
                                  icon: const Icon(Icons.delete_outline),

                              )
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
