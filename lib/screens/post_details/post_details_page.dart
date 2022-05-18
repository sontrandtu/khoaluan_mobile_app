import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:khoaluan_mobile_app/page_routes.dart';
import 'package:khoaluan_mobile_app/screens/post_details/post_detail_view_model.dart';
import 'package:khoaluan_mobile_app/theme/app_bar.dart';
import 'package:khoaluan_mobile_app/widgets/cover_loading.dart';
import 'package:khoaluan_mobile_app/utils/extensions/string_extension.dart';
import 'package:provider/provider.dart';
import '../../theme/color.dart';
import '../../widgets/custom_cached_network_image.dart';
import 'components/bottom_call_bar.dart';
import 'components/preview_images.dart';

class PostDetailsPage extends StatefulWidget {
  const PostDetailsPage({Key? key}) : super(key: key);

  @override
  State<PostDetailsPage> createState() => _PostDetailsPageState();
}

class _PostDetailsPageState extends State<PostDetailsPage> {

  bool showAll = true;

  @override
  Widget build(BuildContext context) {
    return Consumer<PostDetailsViewModel>(
      builder: (context, viewModel, child) => CoverLoading(
        showLoading: viewModel.isLoading,
        isStack: true,
        child: Scaffold(
          appBar: const DefaultAppBar(title: "Chi tiết bài viết"),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                PreviewImages(images: viewModel.postDetailsModel.infoPost?.relatedImagesLists),
                Container(height: 8,color: Colors.blue.withOpacity(0.3)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomNetworkImage(
                        url: viewModel.postDetailsModel.infoAuthPost?.imageUrl?.imageUrl ?? '',
                        width: 60,
                        height: 60,
                        isCircle: true,
                      ),
                      Text(
                        viewModel.postDetailsModel.infoAuthPost?.name ?? '',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                Container(height: 8,color: Colors.blue.withOpacity(0.3),),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          viewModel.postDetailsModel.infoPost?.title ?? '',
                          style: Theme.of(context).textTheme.bodyText2?.copyWith(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        const SizedBox(height: 12),
                        PostProperties(name: 'Địa chỉ: ', content: viewModel.postDetailsModel.infoPost?.address),
                        const SizedBox(height: 12),
                        PostProperties(name: 'Giá cho thuê: ', content: '${viewModel.postDetailsModel.infoPost?.price} VNĐ/tháng'),
                        const SizedBox(height: 12),
                        Text(
                          "Mô tả chi tiết:",
                          style: Theme.of(context).textTheme.bodyText2?.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text.rich(
                          TextSpan(
                            style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
                            children: <InlineSpan>[
                              TextSpan(
                                text: (viewModel.postDetailsModel.infoPost?.description?.length ?? 0) > 200 && showAll ? (viewModel.postDetailsModel.infoPost?.description?.substring(0, 100) ?? '') + "..." : viewModel.postDetailsModel.infoPost?.description,
                                style: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 16,),
                              ),
                              (viewModel.postDetailsModel.infoPost?.description?.length ?? 0 ) > 200 ? WidgetSpan(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      showAll = !showAll;
                                    });
                                  },
                                  child: Text(
                                    showAll ? ' Xem thêm' : ' Thu gọn',
                                    style: const TextStyle(color: Colors.blue, fontSize: 12, fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ) : const TextSpan(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(height: 8,color: Colors.blue.withOpacity(0.3)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Ngày đăng:",
                          style: Theme.of(context).textTheme.bodyText2?.copyWith(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                          )
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Icon(Icons.calendar_today_outlined),
                          const SizedBox(width: 8),
                          Text("${DateTime.now().day - (viewModel.postDetailsModel.infoPost?.createdAt?.day ?? 0)} ngày trước - ${DateFormat('dd/MM/yyyy').format(viewModel.postDetailsModel.infoPost?.createdAt ?? DateTime.now())}")
                        ],
                      )
                    ],
                  ),
                ),
                Container(height: 8,color: Colors.blue.withOpacity(0.3)),
                Align(
                  child: Column(
                    children: [
                      const SizedBox(height: 12),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                            "Bài viết liên quan:",
                            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            )
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 260,
                        child: ListView.separated(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => InkWell(
                              onTap: (){
                                Navigator.of(context).pushNamed(PageRoutes.postDetailsPage, arguments: viewModel.postDetailsModel.relatedPost?[index].id);
                              },
                              child: Container(
                                width: 200,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomNetworkImage(
                                      url: viewModel.postDetailsModel.relatedPost?[index].imagePost?.imageUrl ?? '',
                                      width: 200,
                                      height: 132,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            viewModel.postDetailsModel.relatedPost?[index].title ?? '',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2
                                                ?.copyWith(fontWeight: FontWeight.bold, fontSize: 16),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            "${viewModel.postDetailsModel.relatedPost?[index].price ?? ''} VNĐ/Người",
                                            style: TextStyle(
                                                color: AppColors.primaryColor,
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            DateFormat('dd/MM/yyyy').format(viewModel.postDetailsModel.relatedPost![index].createdAt!),
                                            maxLines: 1,
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
                            ),
                            separatorBuilder: (_, __) => const SizedBox(width: 8),
                            itemCount: viewModel.postDetailsModel.relatedPost?.length ?? 0,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: BottomCallBar(phoneNumber: viewModel.postDetailsModel.infoAuthPost?.phoneNumber),
        ),
      ),
    );
  }
}

class PostProperties extends StatelessWidget {
  final String? name;
  final String? content;
  const PostProperties({
    Key? key, this.name, this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: name,
            style: const TextStyle(
              color: AppColors.textBlack,
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          ),
          TextSpan(
            text: '$content',
            style: TextStyle(color: AppColors.primaryColor, fontSize: 16),),
        ],
      ),
    );
  }
}

