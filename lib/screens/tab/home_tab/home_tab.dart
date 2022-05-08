import 'package:flutter/material.dart';
import 'package:khoaluan_mobile_app/screens/tab/home_tab/home_view_model.dart';
import 'package:khoaluan_mobile_app/utils/extensions/context_extension.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'components/categories_layout.dart';
import 'components/slider_layout.dart';
import 'components/trending_post.dart';
import 'components/your_posts.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final RefreshController _refreshController = RefreshController(initialRefresh: false);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0EAEA),
      body: Consumer<HomeViewModel>(
        builder: (context, viewModel, child) => SmartRefresher(
          controller: _refreshController,
          enablePullUp: false,
          onRefresh: (){
            viewModel.loadData(
                onLoadedCallback: (){
                  _refreshController.refreshCompleted(resetFooterState: true);
                },
                errorCallback: (error){
                  context.showMessage(error,type: MessageType.error);
                }
            );
          },
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SliderLayout(
                  userModel: viewModel.user,
                  images: const [
                    "http://10.0.2.2:3000/api/images/1651069355697.jpg",
                    "http://10.0.2.2:3000/api/images/1651069355697.jpg",
                    "http://10.0.2.2:3000/api/images/1651069355697.jpg",
                  ],
                ),
                Column(
                  children: [
                    CategoriesLayOut(
                      categories: viewModel.categories,
                    ),
                    ListTrendingPost(trendingPosts: viewModel.trendingPosts),
                    YourPosts(yourPosts: viewModel.yourPosts),
                    const SizedBox(height: 80),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),


    );
  }
}


