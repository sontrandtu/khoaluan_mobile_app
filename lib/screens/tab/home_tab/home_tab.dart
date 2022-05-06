import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:khoaluan_mobile_app/model/user_model.dart';
import 'package:khoaluan_mobile_app/screens/tab/home_tab/home_view_model.dart';
import 'package:khoaluan_mobile_app/theme/color.dart';
import 'package:khoaluan_mobile_app/widgets/custom_cached_network_image.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'components/item_name_and_see_all.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<HomeViewModel>(
        builder: (context, viewModel, child) => SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SliderLayout(
                userModel: viewModel.userModel,
                  images: [
                "http://10.0.2.2:3000/api/images/1651069355697.jpg",
                "http://10.0.2.2:3000/api/images/1651069355697.jpg",
                "http://10.0.2.2:3000/api/images/1651069355697.jpg",
              ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Column(
                  children: [
                    ItemNameAndSeeAll(
                      itemName: "Danh mục tìm kiếm",
                      seeAllTap: () {},
                    ),
                    ItemNameAndSeeAll(
                      itemName: "Xu hướng",
                      seeAllTap: () {},
                    ),
                    ItemNameAndSeeAll(
                      itemName: "Dành cho bạn",
                      seeAllTap: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserInfo extends StatelessWidget {
  final UserModel userInfo;
  final GestureTapCallback? addPostTap;

  const UserInfo({
    Key? key,
    required this.userInfo,
    this.addPostTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomNetworkImage(
          url: userInfo.image ?? '',
          width: 60,
          height: 60,
          isCircle: true,
        ),
        const SizedBox(width: 16),
        Text(
          userInfo.name ?? '',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
        ),
        const Spacer(),
        GestureDetector(
          child: const Icon(Icons.post_add_outlined, size: 36, color: Colors.white),
          onTap: addPostTap,
        )
      ],
    );
  }
}

class SliderLayout extends StatefulWidget {
  final List<String> images;
  final UserModel userModel;

  const SliderLayout({Key? key, required this.images, required this.userModel}) : super(key: key);

  @override
  State<SliderLayout> createState() => _SliderLayoutState();
}

class _SliderLayoutState extends State<SliderLayout> {
  int activeIndex = 0;

  Widget buildIndicator(sliders) => AnimatedSmoothIndicator(
      activeIndex: activeIndex,
      count: sliders.length,
      effect: WormEffect(
          dotWidth: 0,
          dotHeight: 0,
          activeDotColor: sliders.isNotEmpty ? AppColors.secondaryColor : Colors.transparent,
          dotColor: sliders.isNotEmpty ? const Color.fromRGBO(157, 157, 158, 1) : Colors.transparent
      )
  );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 200,
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(18), bottomRight: Radius.circular(18)),
          ),
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: UserInfo(userInfo: widget.userModel),
            ),
            const SizedBox(height: 16),
            CarouselSlider.builder(
              itemCount: widget.images.length,
              itemBuilder: (context, index, realIndex) {
                return CustomNetworkImage(url: widget.images.isEmpty ? '' : widget.images[index], width: 355, height: 160, circular: 8, isPlaceholderImage: false);
              },
              options: CarouselOptions(
                height: 160,
                initialPage: 0,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 10),
                autoPlayAnimationDuration: const Duration(milliseconds: 1000),
                autoPlayCurve: Curves.fastOutSlowIn,
                viewportFraction: 1,
                onPageChanged: (index, reason) {
                  setState(() {
                    activeIndex = index;
                  });
                },
              ),
            ),
            const SizedBox(height: 0),
            buildIndicator(widget.images),
          ],
        ),
      ],
    );
  }
}

