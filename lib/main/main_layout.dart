import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:khoaluan_mobile_app/screens/tab/home_tab/home_tab.dart';
import 'package:khoaluan_mobile_app/screens/tab/home_tab/home_view_model.dart';
import 'package:khoaluan_mobile_app/screens/tab/my_post_tab/my_post_tab.dart';
import 'package:khoaluan_mobile_app/screens/tab/my_post_tab/my_post_view_model.dart';
import 'package:khoaluan_mobile_app/screens/tab/roommates_tab/roommates_view_model.dart';
import 'package:khoaluan_mobile_app/utils/extensions/context_extension.dart';
import 'package:provider/provider.dart';

import '../../base/app_provider.dart';
import '../../enum/tab_type.dart';
import '../../theme/color.dart';
import '../page_routes.dart';
import '../screens/tab/account_tab/account_tab.dart';
import '../screens/tab/account_tab/account_view_model.dart';
import '../screens/tab/roommates_tab/roommates_tab.dart';
import '../utils/dialog_utils.dart';
import 'main_view_model.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({Key? key}) : super(key: key);

  @override
  State<MainLayout> createState() => _TabsPageState();
}

class _TabsPageState extends State<MainLayout> with WidgetsBindingObserver {
  int _currentIndex = 0;

  MainViewModel get viewModel => context.read<MainViewModel>();

  final homeNav = GlobalKey<NavigatorState>();
  final accountNav = GlobalKey<NavigatorState>();
  final roommatesNav = GlobalKey<NavigatorState>();
  final myPostNav = GlobalKey<NavigatorState>();
  List<TabType> tabs = TabType.values;
  TabType currentTabType = TabType.home;

  late PageController _pageController;

  @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    super.initState();
    _pageController = PageController();
    Provider
        .of<AppProvider>(context, listen: false)
        .navigateToTabStream
        .listen((event) {
      currentTab = event;
    });
    // onListenerMessage();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget navigationItem({required TabType tabType, required IconData icon}) {
    return MaterialButton(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      minWidth: 30,
      onPressed: () {
        currentTab = tabType;
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Icon(
        icon,
        size: 28,
        color: currentTabType != tabType
            ? AppColors.secondaryColor
            : AppColors.textWhite,
      ),
      const SizedBox(height: 2),
      Text(
        tabType.label,
        style: TextStyle(
            color: currentTabType != tabType
                ? AppColors.secondaryColor
                : AppColors.textWhite,
            fontWeight: FontWeight.bold
        ),
      ),
        ],
      ),
    );
  }

  late bool? isReloadHomeTopic = false;
  late bool? isReloadUserInfo = false;
  late bool? isReloadListRelative = false;
  late bool? isReloadHistory = false;

  set currentTab(TabType value) {
    currentTabType = value;
    context.hideKeyboard();
    _currentIndex = tabs.indexOf(value);
    _pageController.jumpToPage(_currentIndex);
    setState(() {});
    // setState(() {
    //   isReloadHomeTopic = PreferenceManager.getValue<bool>(
    //       PreferenceManager.IS_RELOAD_HOME_TOPIC);
    //   isReloadUserInfo = PreferenceManager.getValue<bool>(
    //       PreferenceManager.IS_RELOAD_USER_INFO);
    //   isReloadListRelative = PreferenceManager.getValue<bool>(
    //       PreferenceManager.IS_RELOAD_FAVORITE);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_currentIndex == 0) {
          homeNav.currentState?.maybePop().then((stackHasItem) {
            if (!stackHasItem) {
              showDefaultDialog(
                context,
                title: 'Thoát ứng dụng',
                content: 'Bạn có chắc chắn muốn thoát?',
                onPressNo: () => Navigator.of(context).pop(),
                onPressYes: () => SystemNavigator.pop(),
              );
            }
          });
        }
        if (_currentIndex == 1) {
          roommatesNav.currentState?.maybePop().then((stackHasItem) {
            if (!stackHasItem) {
              currentTab = TabType.home;
            }
          });
        }
        if (_currentIndex == 2) {
          myPostNav.currentState?.maybePop().then((stackHasItem) {
            if (!stackHasItem) {
              currentTab = TabType.home;
            }
          });
        }
        if (_currentIndex == 1) {
          accountNav.currentState?.maybePop().then((stackHasItem) {
            if (!stackHasItem) {
              currentTab = TabType.home;
            }
          });
        }
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          // extendBodyBehindAppBar: true,
          extendBody: true,
          body: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: <Widget>[
              Navigator(
                  key: homeNav,
                  initialRoute: PageRoutes.homeTab,
                  onGenerateRoute: (RouteSettings settings) {
                    WidgetBuilder builder;
                    switch (settings.name) {
                      case PageRoutes.homeTab:
                        builder = (BuildContext _) =>
                            ChangeNotifierProvider(
                                create: (_) =>
                                    HomeViewModel(repo: context.read()),
                                child: HomeTab());
                        break;
                      default:
                        throw Exception(
                            'HomeNav Invalid Route: ${settings.name}');
                    }
                    return MaterialPageRoute(
                        builder: builder, settings: settings);
                  }),
              Navigator(
                  key: roommatesNav,
                  initialRoute: PageRoutes.roommatesTab,
                  onGenerateRoute: (RouteSettings settings) {
                    WidgetBuilder builder;
                    switch (settings.name) {
                      case PageRoutes.roommatesTab:
                        builder = (BuildContext _) => ChangeNotifierProvider(
                            create: (_) => RoommatesViewModel(repo: context.read()),
                            child: RoommatesTab()
                        );
                        break;
                      default:
                        throw Exception('BookingNav Invalid Route: ${settings.name}');
                    }
                    return MaterialPageRoute(builder: builder, settings: settings);
                  }),
              Navigator(
                key: myPostNav,
                initialRoute: PageRoutes.myPostTab,
                onGenerateRoute: (RouteSettings settings) {
                  WidgetBuilder builder;
                  switch (settings.name) {
                    case PageRoutes.myPostTab:
                      builder = (BuildContext _) => ChangeNotifierProvider(
                          create: (_) => MyPostViewModel(repo: context.read()),
                          child: const MyPostTab()
                      );
                      break;
                    default:throw Exception('VideoNav Invalid Route: ${settings.name}');
                  }
                  return MaterialPageRoute(builder: builder, settings: settings);
                },
              ),
              Navigator(
                  key: accountNav,
                  initialRoute: PageRoutes.accountTab,
                  onGenerateRoute: (RouteSettings settings) {
                    WidgetBuilder builder;
                    switch (settings.name) {
                      case PageRoutes.accountTab:
                        builder = (BuildContext nestedContext) {
                          return ChangeNotifierProvider(
                              create: (_) =>
                                  AccountViewModel(repo: context.read()),
                              child: const AccountTab());
                        };
                        break;
                      default:
                        throw Exception(
                            'AccountNav Invalid Route: ${settings.name}');
                    }
                    return MaterialPageRoute(
                        builder: builder, settings: settings);
                  }),
            ],
          ),
          floatingActionButton: SizedBox(
            width: 52,
            height: 52,
            child: Center(
              child: FloatingActionButton(
                backgroundColor: AppColors.primaryColor,
                child: const Icon(Icons.search, size: 32),
                onPressed: () {
                  Navigator.of(context,rootNavigator: true).pushNamed(PageRoutes.listPostPage);
                  // Navigator.of(context, rootNavigator: true).pushNamed(PageRoutes.treatment, arguments: []);
                },
                tooltip: "Đặt lịch",
              ),
            ),
          ),
          floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
          floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
          bottomNavigationBar: BottomAppBar(
            color: AppColors.primaryColor,
            elevation: 0,
            shape: const CircularNotchedRectangle(),
            notchMargin: 4,
            clipBehavior: Clip.antiAlias,
            child:
            SizedBox(
              height: 56,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      navigationItem(tabType: TabType.home, icon: Icons.home_outlined),
                      navigationItem(tabType: TabType.roommates, icon: Icons.group_add_outlined),
                    ],
                  ),
                  const SizedBox(),
                  Row(
                    children: [
                      navigationItem(tabType: TabType.myPost, icon: Icons.list_alt_outlined),
                      navigationItem(tabType: TabType.account, icon: Icons.person_outlined),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

// @override
// void didChangeAppLifecycleState(AppLifecycleState state) {
//   if (state == AppLifecycleState.resumed) {
//     viewModel.updateOnlineStatus(true);
//     return;
//   }
//   if (state == AppLifecycleState.paused) {
//     viewModel.updateOnlineStatus(false);
//     return;
//   }
// }
}
