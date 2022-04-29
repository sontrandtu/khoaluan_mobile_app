import 'package:flutter/material.dart';

class  RoommatesTab extends StatefulWidget {
  const RoommatesTab({Key? key}) : super(key: key);

  @override
  State<RoommatesTab> createState() => _RoommatesTabState();
}

class _RoommatesTabState extends State<RoommatesTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Text("listPost"),
        ),
      ),
    );
  }
}
