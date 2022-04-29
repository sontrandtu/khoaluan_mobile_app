import 'package:flutter/material.dart';

class MyPostTab extends StatefulWidget {
  const MyPostTab({Key? key}) : super(key: key);

  @override
  State<MyPostTab> createState() => _MyPostTabState();
}

class _MyPostTabState extends State<MyPostTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Text("Home Page"),
        ),
      ),
    );
  }
}
