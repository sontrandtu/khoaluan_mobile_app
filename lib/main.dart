import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:khoaluan_mobile_app/app_config.dart';
import 'package:khoaluan_mobile_app/base/app_provider.dart';
import 'package:khoaluan_mobile_app/main/main_layout.dart';
import 'package:khoaluan_mobile_app/model/category_model.dart';
import 'package:khoaluan_mobile_app/model/my_post_model.dart';
import 'package:khoaluan_mobile_app/page_routes.dart';
import 'package:khoaluan_mobile_app/repository/category_repository.dart';
import 'package:khoaluan_mobile_app/repository/location_repository.dart';
import 'package:khoaluan_mobile_app/repository/post_repository.dart';
import 'package:khoaluan_mobile_app/repository/user_repository.dart';
import 'package:khoaluan_mobile_app/screens/add_post/add_post_page.dart';
import 'package:khoaluan_mobile_app/screens/change_password/change_password_page.dart';
import 'package:khoaluan_mobile_app/screens/change_password/change_password_view_model.dart';
import 'package:khoaluan_mobile_app/screens/change_phone_number/change_phone_number_page.dart';
import 'package:khoaluan_mobile_app/screens/change_phone_number/change_phone_number_view_model.dart';
import 'package:khoaluan_mobile_app/screens/forgot_password/forgot_password_page.dart';
import 'package:khoaluan_mobile_app/screens/list_post_page/list_post_view_model.dart';
import 'package:khoaluan_mobile_app/screens/login_and_register/register/register_page.dart';
import 'package:khoaluan_mobile_app/screens/login_and_register/register/register_view_model.dart';
import 'package:khoaluan_mobile_app/screens/map_page/map_view_model.dart';
import 'package:khoaluan_mobile_app/screens/post_by_category/post_by_category_view_model.dart';
import 'package:khoaluan_mobile_app/screens/post_by_category/posts_by_category_page.dart';
import 'package:khoaluan_mobile_app/screens/post_details/post_detail_view_model.dart';
import 'package:khoaluan_mobile_app/screens/post_details/post_details_page.dart';
import 'package:khoaluan_mobile_app/screens/search_post/dart/search_post_page.dart';
import 'package:khoaluan_mobile_app/screens/search_post/dart/search_post_view_model.dart';
import 'package:khoaluan_mobile_app/screens/update_post/update_post_page.dart';
import 'package:khoaluan_mobile_app/screens/update_post/update_post_view_model.dart';
import 'package:khoaluan_mobile_app/screens/update_user/update_user_page.dart';
import 'package:khoaluan_mobile_app/screens/update_user/update_user_view_model.dart';
import 'package:khoaluan_mobile_app/theme/color.dart';
import 'package:khoaluan_mobile_app/theme/style.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';
import 'package:firebase_core/firebase_core.dart';

import 'preference/preference.dart';
import 'screens/add_post/add_post_view_model.dart';
import 'screens/forgot_password/forgot_password_view_model.dart';
import 'screens/list_my_post/list_my_post_page.dart';
import 'screens/list_my_post/list_my_post_view_model.dart';
import 'screens/list_post_page/list_post_page.dart';
import 'screens/login_and_register/login/login_page.dart';
import 'screens/login_and_register/login/login_view_model.dart';
import 'screens/map_page/map_page.dart';

final GlobalKey<NavigatorState> mainKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await PreferenceManager.init();
  await Firebase.initializeApp();

  String? token = PreferenceManager.getValue<String>(PreferenceManager.KEY_TOKEN);

  runApp(MultiProvider(
    providers: [
      Provider(create: (_) => UserRepository()),
      Provider(create: (_) => CategoryRepository()),
      Provider(create: (_) => PostRepository()),
      Provider(create: (_) => LocationRepository()),
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
      navigatorKey: mainKey,
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
      // PageRoutes.rootApp
      isLogged ? PageRoutes.rootApp : PageRoutes.loginPage,
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
        create: (_) => ListPostViewModel(postRepo: context.watch(), isSearch: false),
        child: const ListPostPage(isSearch: true),
      );
    },
    PageRoutes.searchPostPage: (BuildContext context) {
      return ChangeNotifierProvider(
        create: (_) => SearchPostViewModel(categoryRepo: context.watch()),
        child: const SearchPostPage(),
      );
    },
    PageRoutes.addPostPage: (BuildContext context) {
      return ChangeNotifierProvider(
        create: (_) => AddPostViewModel(
          userRepo: context.read<UserRepository>(),
          postRepo: context.watch(),
          locationRepo: context.read<LocationRepository>(),
          categoryRepo: context.read<CategoryRepository>(),
        ),
        child: const AddPostPage(),
      );
    },
    PageRoutes.mapPage: (BuildContext context) {
      return ChangeNotifierProvider(
        create: (_) => MapViewModel(postRepo: context.watch()),
        child: const MapPage(),
      );
    },
    PageRoutes.postDetailsPage: (BuildContext context) {
      final arguments = ModalRoute.of(context)?.settings.arguments as String;
      return ChangeNotifierProvider(
        create: (_) => PostDetailsViewModel(postRepo: context.watch(), postId: arguments),
        child: const PostDetailsPage(),
      );
    },
    PageRoutes.updateUser: (BuildContext context) {
      return ChangeNotifierProvider(
        create: (_) => UpdateUserViewModel(userRepo: context.watch()),
        child: const UpdateUserPage(),
      );
    },
    PageRoutes.changePasswordPage: (BuildContext context) {
      return ChangeNotifierProvider(
        create: (_) => ChangePasswordViewModel(userRepo: context.watch()),
        child: const ChangePasswordPage(),
      );
    },
    PageRoutes.changPhoneNumberPage: (BuildContext context) {
      return ChangeNotifierProvider(
        create: (_) => ChangePhoneNumberViewModel(userRepo: context.watch()),
        child: const ChangePhoneNumberPage(),
      );
    },
    PageRoutes.postByCategoryPage: (BuildContext context) {
      final CategoryModel args = ModalRoute.of(context)?.settings.arguments as CategoryModel;
      return ChangeNotifierProvider(
        create: (_) => PostByCategoryViewModel(postRepo: context.watch(), category: args),
        child: const PostsByCategoryPage(),
      );
    },
    PageRoutes.forgotPasswordPage: (BuildContext context) {
      return ChangeNotifierProvider(
        create: (_) => ForgotPasswordViewModel(userRepo: context.watch()),
        child: const ForgotPasswordPage(),
      );
    },
    PageRoutes.listMyPostPage: (BuildContext context) {
      return ChangeNotifierProvider(
        create: (_) => ListMyPostViewModel(postRepo: context.watch(), userRepo: context.read<UserRepository>()),
        child: const ListMyPostPage(),
      );
    },
    PageRoutes.updatePostPage: (BuildContext context) {
      final args = ModalRoute.of(context)?.settings.arguments as DataPost;
      return ChangeNotifierProvider(
        create: (_) => UpdatePostViewModel(
            postRepo: context.watch(),
            categoryRepo: context.read<CategoryRepository>(),
            locationRepo: context.read<LocationRepository>(),
            dataPost: args,
        ),
        child: const UpdatePostPage(),
      );
    },
  };
}
