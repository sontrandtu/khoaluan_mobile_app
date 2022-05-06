import 'package:flutter/material.dart';
import 'package:khoaluan_mobile_app/page_routes.dart';

class ListPostPage extends StatefulWidget {
  const ListPostPage({Key? key}) : super(key: key);

  @override
  State<ListPostPage> createState() => _ListPostPageState();
}

class _ListPostPageState extends State<ListPostPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ElevatedButton(
          child: Text("Next"),
          onPressed: (){
            Navigator.of(context).pushNamed(PageRoutes.mapPage);
          },
        ),
      )
    );
  }
}
