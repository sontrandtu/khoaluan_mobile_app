import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool canBack;

  const DefaultAppBar({
    Key? key,
    this.title,
    this.canBack = true,
  })  : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('$title'.toUpperCase()),
      leading: canBack
          ? IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(CupertinoIcons.back),
            splashRadius: 28,
      )
          : const SizedBox(),
      centerTitle: true,
    );
  }
}
