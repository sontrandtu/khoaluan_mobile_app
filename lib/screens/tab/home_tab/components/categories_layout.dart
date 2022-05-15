import 'package:flutter/material.dart';
import 'package:khoaluan_mobile_app/page_routes.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../model/category_model.dart';
import '../../../../theme/color.dart';
import 'item_name_and_see_all.dart';

class CategoriesLayOut extends StatelessWidget {
  final List<CategoryModel> categories;
  const CategoriesLayOut({
    Key? key, required this.categories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          ItemNameAndSeeAll(
            itemName: "Danh mục tìm kiếm",
            seeAllTap: () {
              Navigator.of(context, rootNavigator: true).pushNamed(PageRoutes.searchPostPage);
            },
          ),
          categories.isEmpty ? Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: GridView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (_, index) {
                return Container(
                  height: 90,
                  width: 180,
                  decoration: BoxDecoration(
                    color: AppColors.textWhite,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        width: 1, color: Colors.grey.withOpacity(0.2)),
                  ),
                );
              },
              itemCount: 2,
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                childAspectRatio: 180 / 160,
              ),
            ),
          )
              : GridView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (_, index) {
              return Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.cyan,
                        offset: Offset(0,1),
                        blurStyle: BlurStyle.solid
                    ),
                  ],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(width: 1, color: Colors.grey.withOpacity(0.2)),
                ),
                child: Text(
                  categories[index].name ?? '',
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            },
            itemCount: categories.length,
            gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
              childAspectRatio: 180 / 160,
            ),
          ),
        ],
      ),
    );
  }
}