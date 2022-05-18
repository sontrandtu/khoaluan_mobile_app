import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:khoaluan_mobile_app/base/base_view_model.dart';
import 'package:khoaluan_mobile_app/model/post_model.dart';
import 'package:khoaluan_mobile_app/page_routes.dart';
import 'package:khoaluan_mobile_app/repository/post_repository.dart';
import 'package:khoaluan_mobile_app/widgets/buttons/custom_default_button.dart';

import '../../theme/color.dart';

class MapViewModel extends BaseViewModel {
  PostRepository postRepo;

  List<Marker> markers = [];
  List<PostModel> posts = [];
  BuildContext? context;

  MapViewModel({required this.postRepo}) : super(postRepo) {
    getData();
  }

  Future<void> getData() async {
    setLoading = true;
    final response = await postRepo.getListPostByCategory(categoryId: 'all');
    if (response.isOk) {
      posts.addAll(response.data?.data ?? []);
      mapMarker();
    }
    setLoading = false;
  }

  List<String> mapStringToLatLng(String latLng) {
    return latLng.split(",");
  }

  Future<void> mapMarker() async {
    markers.addAll(posts.map(
          (e) {
        List<String> latLng = mapStringToLatLng(e.rootLocation ?? '');
        return Marker(
          onTap: () {
            showModalBottomSheet(
              context: context!,
              builder: (context)=> Container(
                height: 200,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: "Tiêu đề: ",
                            style: TextStyle(
                              color: AppColors.textBlack,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          TextSpan(
                            text: e.title ?? '',
                            style: TextStyle(color: AppColors.primaryColor, fontSize: 16),),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: "Giá: ",
                            style: TextStyle(
                              color: AppColors.textBlack,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          TextSpan(
                            text: '${e.price} VNĐ/tháng',
                            style: TextStyle(color: AppColors.primaryColor, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: "Địa chỉ: ",
                            style: TextStyle(
                              color: AppColors.textBlack,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          TextSpan(
                            text: e.address ?? '',
                            style: TextStyle(color: AppColors.primaryColor, fontSize: 16),),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    CustomDefaultButton(
                        onTap: () => Navigator.of(context).pushNamed(PageRoutes.postDetailsPage, arguments: e.id). then((value) => Navigator.of(context).pop()),
                      title: "Xem chi tiết",
                      padding: 60,
                      height: 40,
                    ),
                  ],
                ),
              ),
            );
          },
          markerId: MarkerId(e.id ?? "postId"),
          position: LatLng(
            double.parse(latLng[0]),
            double.parse(latLng[1]),
          ),
        );
      },
    ).toList());
  }
}
