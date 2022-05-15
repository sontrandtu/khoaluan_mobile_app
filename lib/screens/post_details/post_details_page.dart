import 'package:flutter/material.dart';
import 'package:khoaluan_mobile_app/screens/post_details/post_detail_view_model.dart';
import 'package:khoaluan_mobile_app/theme/app_bar.dart';
import 'package:khoaluan_mobile_app/utils/dialog_utils.dart';
import 'package:khoaluan_mobile_app/widgets/cover_loading.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../theme/color.dart';
import 'components/preview_images.dart';

class PostDetailsPage extends StatefulWidget {
  const PostDetailsPage({Key? key}) : super(key: key);

  @override
  State<PostDetailsPage> createState() => _PostDetailsPageState();
}

class _PostDetailsPageState extends State<PostDetailsPage> {

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
            child: PreviewImages(images: viewModel.postDetailsModel.infoPost?.relatedImagesLists),
          ),
          bottomNavigationBar: BottomAppBar(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: 72,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.35),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Liên hệ: ",
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        color: Colors.pink,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    viewModel.postDetailsModel.infoAuthPost?.phoneNumber ?? "",
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                    onTap: () {
                      showDefaultDialog(
                          context,
                          title: "Gọi điện thoại",
                          content: "Bạn có muốn gọi tới số ${viewModel.postDetailsModel.infoAuthPost?.phoneNumber}",
                          onPressNo: () => Navigator.of(context).pop(),
                          onPressYes: (){
                            launch('tel:+${viewModel.postDetailsModel.infoAuthPost?.phoneNumber}');
                            Navigator.of(context).pop();
                          },
                      );
                    },
                    child: Container(
                      width: 112,
                      height: 60,
                      decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(12)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Gọi ngay",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                ?.copyWith(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 8),
                          const Icon(
                            Icons.call,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
