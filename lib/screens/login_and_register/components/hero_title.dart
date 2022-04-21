import 'package:flutter/material.dart';

class HeroTitle extends StatelessWidget {
  final String? title;
  final String? content;
  final String? image;
  const HeroTitle({
    Key? key,
    this.title,
    this.content,
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        (image == null) ? const SizedBox() : Image.asset(image!),
        const SizedBox(height: 20),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title ?? '',
            style: const TextStyle(
              fontSize: 20,
              fontFamily: 'RobotoSlab',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            content ?? '',
            style: const TextStyle(
              fontSize: 14,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
