import 'package:flutter/material.dart';
import 'package:khoaluan_mobile_app/repository/post_repository.dart';
import 'package:khoaluan_mobile_app/screens/list_post_page/list_post_page.dart';
import 'package:khoaluan_mobile_app/screens/list_post_page/list_post_view_model.dart';
import 'package:khoaluan_mobile_app/theme/app_bar.dart';
import 'package:khoaluan_mobile_app/widgets/cover_loading.dart';
import 'package:provider/provider.dart';

import '../../../page_routes.dart';
import '../../../theme/color.dart';
import 'search_post_view_model.dart';

class SearchPostPage extends StatefulWidget {
  const SearchPostPage({Key? key}) : super(key: key);

  @override
  State<SearchPostPage> createState() => _SearchPostPageState();
}

class _SearchPostPageState extends State<SearchPostPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<SearchPostViewModel>(
        builder: (context, viewModel, child) => CoverLoading(
          showLoading: viewModel.isLoading,
          child: Scaffold(
            appBar: const DefaultAppBar(title: "Tìm khòng trọ"),
            body: DefaultTabController(
              length: viewModel.categories.length,
              child: Column(
                children: [
                  Container(
                    constraints: const BoxConstraints(maxHeight: 100),
                    child: Material(
                      color: AppColors.textWhite,
                      elevation: 8,

                      child: viewModel.categories.isNotEmpty
                      ? TabBar(
                        indicatorWeight: 3,
                        isScrollable: true,
                        tabs: List.generate(viewModel.categories.length, (int index) {
                              return SizedBox(
                                height: 40,
                                child: Tab(
                                  child: Text(
                                    viewModel.categories[index].nameCategories.toString(),
                                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                                      color: AppColors.textBlack,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ) : null,
                    ),
                  ),
                  Expanded(
                    child: viewModel.categories.isNotEmpty
                    ? TabBarView(
                      children: List.generate(viewModel.categories.length, (index) {
                        return ChangeNotifierProvider(
                          create: (_) => ListPostViewModel(
                              postRepo: context.watch<PostRepository>(),
                            categoryId: viewModel.categories[index].id,
                          ),
                          child: const ListPostPage(),
                        );
                      }),
                    ) : const SizedBox(),
                  ),
                ],
              ),
            ),
            floatingActionButton: Container(
              height: 56,
              width: 56,
              decoration: BoxDecoration(
                  color: AppColors.primaryColor, shape: BoxShape.circle),
              child: IconButton(
                icon: const Icon(Icons.map_outlined, color: AppColors.textWhite),
                onPressed: () {
                  Navigator.of(context).pushNamed(PageRoutes.mapPage);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
