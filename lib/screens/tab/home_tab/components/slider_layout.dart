import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:khoaluan_mobile_app/page_routes.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../model/user_model.dart';
import '../../../../theme/color.dart';
import '../../../../widgets/custom_cached_network_image.dart';
import 'user_infor_widget.dart';

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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Stack(
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
                child: UserInfo(
                    userInfo: widget.userModel,
                  addPostTap: () => Navigator.of(context, rootNavigator: true).pushNamed(PageRoutes.addPostPage),
                ),
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
      ),
    );
  }
}