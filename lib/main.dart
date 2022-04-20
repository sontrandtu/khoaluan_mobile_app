import 'package:flutter/material.dart';
import 'package:khoaluan_mobile_app/repository/user_repository.dart';
import 'package:khoaluan_mobile_app/screens/login/login.dart';
import 'package:khoaluan_mobile_app/screens/login/login_view_model.dart';
import 'package:khoaluan_mobile_app/theme/color.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => UserRepository()),
      ],
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: primary,
      ),
      home: ChangeNotifierProvider(
        create: (_) => LoginViewModel(userRepo: context.watch()),
        child: Login(),
      ),
    );
  }
}
