import 'package:flutter/material.dart';
import 'package:khoaluan_mobile_app/model/post_model.dart';
import 'package:khoaluan_mobile_app/page_routes.dart';
import 'package:khoaluan_mobile_app/widgets/custom_cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../theme/color.dart';
import 'item_name_and_see_all.dart';

class LatestPost extends StatelessWidget {
  final List<PostModel> latestPost;

  const LatestPost({
    Key? key,
    required this.latestPost,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: ItemNameAndSeeAll(
            itemName: "Tin mới nhất",
            seeAllTap: () {
              Navigator.of(context, rootNavigator: true).pushNamed(PageRoutes.listPostPage);
            },
          ),
        ),
        latestPost.isEmpty ? Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (_, index) {
              return Container(
                height: 90,
                padding: const EdgeInsets.only(top: 15, bottom: 15, left: 10, right: 10),
                margin: const EdgeInsets.only(top: 5, bottom: 10, left: 10, right: 10),
                decoration: BoxDecoration(
                  color: AppColors.textWhite,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(width: 1, color: Colors.grey.withOpacity(0.2)),
                ),
              );
            },
            itemCount: 4,
            separatorBuilder: (_, __) {
              return const SizedBox(width: 10);
            },
          ),
        ): ListView.separated(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (_, index) {
            return InkWell(
              onTap: (){
                Navigator.of(context, rootNavigator: true).pushNamed(PageRoutes.postDetailsPage, arguments: latestPost[index].id);
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
                        url: latestPost[index].imageUrl,
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
                              "${latestPost[index].price ?? ''} VNĐ/Người",
                              style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            latestPost[index].title ?? '',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                ?.copyWith(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            latestPost[index].address ?? '',
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
          itemCount: latestPost.length,
          separatorBuilder: (_, __) {
            return const SizedBox(width: 12);
          },
        ),
      ],
    );
  }
}
