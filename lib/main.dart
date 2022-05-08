import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:khoaluan_mobile_app/app_config.dart';
import 'package:khoaluan_mobile_app/base/app_provider.dart';
import 'package:khoaluan_mobile_app/main/main_layout.dart';
import 'package:khoaluan_mobile_app/page_routes.dart';
import 'package:khoaluan_mobile_app/repository/category_repository.dart';
import 'package:khoaluan_mobile_app/repository/post_repository.dart';
import 'package:khoaluan_mobile_app/repository/user_repository.dart';
import 'package:khoaluan_mobile_app/screens/list_post_page/list_post_view_model.dart';
import 'package:khoaluan_mobile_app/screens/login_and_register/register/register_page.dart';
import 'package:khoaluan_mobile_app/screens/login_and_register/register/register_view_model.dart';
import 'package:khoaluan_mobile_app/screens/search_post/dart/search_post_page.dart';
import 'package:khoaluan_mobile_app/screens/search_post/dart/search_post_view_model.dart';
import 'package:khoaluan_mobile_app/theme/color.dart';
import 'package:khoaluan_mobile_app/theme/style.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';

import 'preference/preference.dart';
import 'screens/list_post_page/list_post_page.dart';
import 'screens/login_and_register/login/login_page.dart';
import 'screens/login_and_register/login/login_view_model.dart';
import 'screens/map_page/map_page.dart';

final GlobalKey<NavigatorState> mainKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await PreferenceManager.init();

  String? token = PreferenceManager.getValue<String>(PreferenceManager.KEY_TOKEN);

  runApp(MultiProvider(
    providers: [
      Provider(create: (_) => UserRepository()),
      Provider(create: (_) => CategoryRepository()),
      Provider(create: (_) => PostRepository()),
      ChangeNotifierProvider(create: (_) => AppProvider())
    ],
    child: MyApp(
      isLogged: (token != null && token.isNotEmpty) ? true : false,
    ),
  ));
}

class MyApp extends StatelessWidget {
  final bool isLogged;
  const MyApp({Key? key, this.isLogged = false}) : super(key: key);

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
        textTheme: AppStyles.textTheme,
      ),
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: Colors.black45,
        cardColor: Colors.black87,
      ),
      themeMode: ThemeMode.light,
      routes: _pageMap(),
      initialRoute:
      PageRoutes.rootApp
      // isLogged ? PageRoutes.rootApp : PageRoutes.loginPage,
    );
  }
}

_pageMap() {
  return <String, WidgetBuilder>{
    PageRoutes.rootApp: (BuildContext context) {
      return ChangeNotifierProvider(
        create: (_) => LoginViewModel(userRepo: context.watch()),
        child: const MainLayout(),
      );
    },
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
    PageRoutes.listPostPage: (BuildContext context) {
      return ChangeNotifierProvider(
        create: (_) => ListPostViewModel(postRepo: context.watch()),
        child: const ListPostPage(),
      );
    },
    PageRoutes.searchPostPage: (BuildContext context) {
      return ChangeNotifierProvider(
        create: (_) => SearchPostViewModel(categoryRepo: context.watch()),
        child: const SearchPostPage(),
      );
    },
    PageRoutes.mapPage: (BuildContext context) {
      return ChangeNotifierProvider(
        create: (_) => LoginViewModel(userRepo: context.watch()),
        child: const MapPage(),
      );
    },
  };
}
