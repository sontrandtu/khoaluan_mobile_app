import 'package:cached_network_image/cached_network_image.dart';
import 'package:khoaluan_mobile_app/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../res.dart';

class CustomNetworkImage extends StatelessWidget {
  final double width;
  final double height;
  final String url;
  final double circular;
  final String borderStyle;
  final bool isPlaceholderImage;
  final bool isCircle;
  final Color backgroundColor;
  final double borderWidth;
  final Color borderColor;

  const CustomNetworkImage(
      {Key? key,
      required this.url,
      required this.width,
      required this.height,
      this.circular = 15,
      this.borderStyle = 'all',
      this.isPlaceholderImage = true,
      this.isCircle = false,
      this.backgroundColor = AppColors.secondaryColor,
      this.borderWidth = 0,
      this.borderColor = AppColors.textPrimaryColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
        imageUrl: url,
        placeholder: (_, __) {
          return Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: backgroundColor,
              shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
              border: borderWidth != 0
                  ? Border.all(width: borderWidth, color: borderColor)
                  : null,
              borderRadius: isCircle
                  ? null
                  : borderStyle == 'top'
                      ? BorderRadius.only(
                          topLeft: Radius.circular(circular),
                          topRight: Radius.circular(circular))
                      : borderStyle == 'bottom'
                          ? BorderRadius.only(
                              bottomLeft: Radius.circular(circular),
                              bottomRight: Radius.circular(circular))
                          : BorderRadius.circular(circular),
              image: isPlaceholderImage
                  ? const DecorationImage(
                      image: AssetImage(Res.imagePlaceHolder),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
          );
        },
        errorWidget: (_, __, ___) => Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                color: backgroundColor,
                shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
                border: borderWidth != 0
                    ? Border.all(width: borderWidth, color: borderColor)
                    : null,
                borderRadius: isCircle
                    ? null
                    : borderStyle == 'top'
                        ? BorderRadius.only(
                            topLeft: Radius.circular(circular),
                            topRight: Radius.circular(circular))
                        : borderStyle == 'bottom'
                            ? BorderRadius.only(
                                bottomLeft: Radius.circular(circular),
                                bottomRight: Radius.circular(circular))
                            : BorderRadius.circular(circular),
                image: isPlaceholderImage
                    ? const DecorationImage(
                        image: AssetImage(Res.imagePlaceHolder),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
            ),
        imageBuilder: (context, imageProvider) => Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
                border: borderWidth != 0
                    ? Border.all(width: borderWidth, color: borderColor)
                    : null,
                borderRadius: isCircle
                    ? null
                    : borderStyle == 'top'
                        ? BorderRadius.only(
                            topLeft: Radius.circular(circular),
                            topRight: Radius.circular(circular))
                        : borderStyle == 'bottom'
                            ? BorderRadius.only(
                                bottomLeft: Radius.circular(circular),
                                bottomRight: Radius.circular(circular))
                            : BorderRadius.circular(circular),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ));
  }
}
