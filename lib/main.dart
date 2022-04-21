import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:khoaluan_mobile_app/app_config.dart';
import 'package:khoaluan_mobile_app/page_routes.dart';
import 'package:khoaluan_mobile_app/repository/user_repository.dart';
import 'package:khoaluan_mobile_app/screens/login_and_register/register/register_page.dart';
import 'package:khoaluan_mobile_app/screens/login_and_register/register/register_view_model.dart';
import 'package:khoaluan_mobile_app/theme/color.dart';
import 'package:khoaluan_mobile_app/theme/style.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';

import 'screens/login_and_register/login/login_page.dart';
import 'screens/login_and_register/login/login_view_model.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      Provider(create: (_) => UserRepository()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: AppColors.primaryColor,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
    ));
    final ThemeData theme = ThemeData.light();

    return MaterialApp(
      builder: (context, child) {
        return ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(context, child!),
          maxWidth: 1200,
          minWidth: 375,
          defaultScale: true,
          breakpoints: [
            const ResponsiveBreakpoint.resize(450, name: MOBILE),
            const ResponsiveBreakpoint.autoScale(800, name: TABLET),
            const ResponsiveBreakpoint.autoScale(1600, name: TABLET),
            const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
            const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
          ],
        );
      },
      debugShowCheckedModeBanner: false,
      title: AppConfig.title,
      theme: ThemeData(
          // Define the default brightness and colors.
          primaryColor: AppColors.primaryColor,
          primarySwatch: AppColors.primaryColor,
          buttonTheme: theme.buttonTheme.copyWith(
            buttonColor: AppColors.secondaryColor,
            textTheme: ButtonTextTheme.primary,
          ),
          dividerColor: Colors.grey.withOpacity(0.1),
          // Define the default font family.
          fontFamily: 'Roboto',
          textTheme: AppStyles.textTheme),
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: Colors.black45,
        cardColor: Colors.black87,
      ),
      themeMode: ThemeMode.light,
      routes: _pageMap(),
      initialRoute: PageRoutes.loginPage,
    );
  }
}

_pageMap() {
  return <String, WidgetBuilder>{
    PageRoutes.loginPage: (BuildContext context) {
      return ChangeNotifierProvider(
        create: (_) => LoginViewModel(userRepo: context.watch()),
        child: const LoginPage(),
      );
    },
    PageRoutes.registerPage: (BuildContext context) {
      return ChangeNotifierProvider(
        create: (_) => RegisterViewModel(userRepo: context.watch()),
        child: const RegisterPage(),
      );
    },
  };
}
