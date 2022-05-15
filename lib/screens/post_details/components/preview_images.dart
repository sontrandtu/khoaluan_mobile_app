import 'package:flutter/material.dart';
import 'package:khoaluan_mobile_app/theme/color.dart';
import 'package:khoaluan_mobile_app/utils/extensions/string_extension.dart';

import '../../../model/relatived_image_model.dart';
import '../../../widgets/custom_cached_network_image.dart';

class PreviewImages extends StatefulWidget {
  final List<RelatedImagesList>? images;
  const PreviewImages({
    Key? key,
    this.images,
  }) : super(key: key);

  @override
  State<PreviewImages> createState() => _PreviewImagesState();
}

class _PreviewImagesState extends State<PreviewImages> {

  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: CustomNetworkImage(
            url: widget.images?[selectedIndex].url?.imageUrl ?? '',
            width: 300,
            height: 150,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: SizedBox(
            height: 100,
            child:
            ((widget.images?.length ?? 0) > 3) ? ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: selectedIndex == index ? Border.all(color: AppColors.primaryColor , width: 1.5) : null,
                  ),
                  child: CustomNetworkImage(
                    url: widget.images?[index].url?.imageUrl ?? '',
                    width: 100,
                    height: 100,
                  ),
                ),
              ),
              itemCount:widget.images?.length ?? 0,
              separatorBuilder: (_, __) =>
              const SizedBox(width: 12),
            )
                : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(widget.images?.length ?? 0, (index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: GestureDetector(
                  onTap: (){
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                        border: selectedIndex == index ? Border.all(color: AppColors.primaryColor , width: 1.5) : null,
                    ),
                    child: CustomNetworkImage(
                      url: widget.images?[index].url?.imageUrl ??'',
                      width: 100,
                      height: 100,
                    ),
                  ),
                ),
              ),
              ),
            ),
          ),
        )
      ],
    );
  }
}