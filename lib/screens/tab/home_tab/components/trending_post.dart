import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../model/post_model.dart';
import '../../../../theme/color.dart';
import '../../../../widgets/custom_cached_network_image.dart';
import 'item_name_and_see_all.dart';

class ListTrendingPost extends StatelessWidget {
  final List<PostModel> trendingPosts;

  const ListTrendingPost({
    Key? key,
    required this.trendingPosts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: ItemNameAndSeeAll(
            itemName: "Xu hướng",
            seeAllTap: () {},
          ),
        ),
        SizedBox(
          height: 236,
          child: trendingPosts.isEmpty
              ? Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: ListView.separated(
                padding: const EdgeInsets.only(left: 12, right: 12),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) {
                  return Container(
                    width: 200,
                    padding: const EdgeInsets.only(
                        top: 25, bottom: 20, left: 15, right: 15),
                    decoration: BoxDecoration(
                      color: AppColors.textWhite,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          width: 1, color: Colors.grey.withOpacity(0.2)),
                    ),
                  );
                },
                separatorBuilder: (_, __) {
                  return const SizedBox(width: 12);
                },
                itemCount: 5),
          )
              : ListView.separated(
            padding: const EdgeInsets.only(left: 12, right: 12),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => Container(
              width: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomNetworkImage(
                    url: trendingPosts[index].imageUrl,
                    width: 200,
                    height: 132,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          trendingPosts[index].title ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              ?.copyWith(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(height: 10),
                        Text(
                            "${trendingPosts[index].price ?? ''} VNĐ/Người",
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          trendingPosts[index].address ?? '',
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
            itemCount: 6,
            separatorBuilder: (_, __) {
              return const SizedBox(width: 12);
            },
          ),
        )
      ],
    );
  }
}
