import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color bgColor = Color(0xfff7f7f7);
  static MaterialColor primaryColor = const MaterialColor(
    0xFFD7A444,
    <int, Color>{
      50: Color(0xFFD7A444),
      100: Color(0xFFD7A444),
      200: Color(0xFFD7A444),
      300: Color(0xFFD7A444),
      400: Color(0xFFD7A444),
      500: Color(0xFFD7A444),
      600: Color(0xFFD7A444),
      700: Color(0xFFD7A444),
      800: Color(0xFFD7A444),
      900: Color(0xFFD7A444),
    },
  );
  static const MaterialColor secondaryColor = MaterialColor(
    0xFF3B2313,
    <int, Color>{
      50: Color(0xFF3B2313),
      100: Color(0xFF3B2313),
      200: Color(0xFF3B2313),
      300: Color(0xFF3B2313),
      400: Color(0xFF3B2313),
      500: Color(0xFF3B2313),
      600: Color(0xFF3B2313),
      700: Color(0xFF3B2313),
      800: Color(0xFF3B2313),
      900: Color(0xFF3B2313),
    },
  );

  static MaterialColor alertColor = const MaterialColor(
    0xff899F8F,
    <int, Color>{
      50: Color(0xFFFFF5F5),
      100: Color(0xFFFFF5F5),
      200: Color(0xFFFFE5E6),
      300: Color(0xFFFEB8B8),
      400: Color(0xFFF46F6F),
      500: Color(0xffDC3C3C),
      600: Color(0xFFBD2828),
      700: Color(0xFFA02222),
      800: Color(0xFF7E1B1B),
      900: Color(0xFF541212),
    },
  );
  static const Color accentColor = Color(0xFF2E9E4C);
  static const Color textPrimaryColor = Color(0xFFD7A444);
  static const Color textSecondaryColor = Color(0xFF3B2313);
  static const Color lightGrey = Color(0xFFBFBFBF);
  static const Color facebook = Color(0xFF3b5998);
  static const Color grey = Color(0xffdbdbdb);
  static const Color inactiveButton = Color(0xFFEAEAEA);
  static const Color activeButton = Color(0xFF2E9E4C);
  static const Color inActiveButton = Color(0xffBBBBBB);
  static const Color pinCodeTextFieldColor = Color(0xFFDCDCDC);
  static const Color textDefault = Color(0xFF3D4B5C);
  static const Color pickerDefaultColor = Color(0xFF262626);
  static const Color textGray = Color(0xFF969696);
  static const Color borderGray = Color(0xFF7C7D80);
  static const Color textBlack = Color(0xFF29323D);
  static const Color backgroundDarkGray = Color(0xFF24272C);
  static const Color backgroundGray = Color(0xFF7C7D80);
  static const Color textWhite = Color(0xFFFFFFFF);
  static const Color backgroundWhite = Color(0xFFFFFFFF);
  static const Color backgroundPage = Color(0xFFFAFAFA);
  static const Color backgroundBlack = Color(0xFF111315);
  static const Color progressBarPlayedColor = Color(0xFFFEC52E);
  static const Color progressBarHandleColor = Color(0xFFFEC52E);
  static const Color progressBarBufferedColor = Color(0xB3FFFFFF);
  static const Color progressBarBackgroundColor = Color(0xFF24272C);
  static const Color backgroundChip = Color(0xFF24272C);
  static const Color textRed = Color(0xFFFF0000);
  static const Color backgroundCountChat = Color(0xFFD30101);
  static const Color titleTextColor = Color(0xff48668a);
  static const Color defaultTextColor = Color(0xff1f3ca8);
  static const Color bgInputColor = Color(0xffe7effa);
  static const Color searchBarColor = Color(0xffe7effa);
  static const Color dividerColor = Color(0xffe7effa);
  static const Color textSelectedColor = Color(0xff0057BD);
  static const Color textUnSelectedColor = Color(0xff52647A);
  static const Color textInputColor = Color(0xff314768);
  static const Color errorInputColor = Color(0xfff75252);
  static const Color redTextColor = Color(0xfff75252);
  static const Color blueTextColor = Color(0xff326fe3);
  static const Color loadingIndicatorColor = Color(0xff326fe3);
  static const Color radioActiveColor = Color(0xff326fe3);
  static const Color dividerGray = Color(0xffC2CBD6);
  static const Color disableColor = Color(0xffBCBCBC);
  static const Color disableTextColor = Color(0xff747474);
  static const Color indicatorActiveColor = Color(0xff558aff);
  static const Color indicatorInActiveColor = Color(0xffc9d3de);
  static const Color iconDownColor = Color(0xff6f84a4);
  static const Color iconDefaultColor = Color(0xff000000);
  static const Color iconActiveColor = Color(0xFF0057BD);
  static const Color hintTextColor = Color(0xff8c8c8c);
  static const Color buttonTranslucent = Color(0x99333333);
  static const Color scaffoldBackground = Color(0xFFFFFFFF);
  static const Color fillSearchBar = Color(0xFFF5F6F5);
  static const Color activeIndicator = Color(0XFF2E9E4C);
  static const Color inactiveIndicator = Color(0xFFB7E4BB);
  static const Color onlineUser = Color(0xFF039600);

  static const Color textDark = Color(0xFF14191F);
  static const Color darkBlue = Color(0xFF0057BD);
  static const Color textBlue = Color(0xFF006EF0);
  static const Color subTitleTex = Color(0xFF3D4B5C);

  static MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    final swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }
}

const primary = Color(0xFFe6b56c);
const secondary = Color(0xFFe96561);

const mainColor = Color(0xFF000000);
const darker = Color(0xFF3E4249);
const appBgColor = Color(0xFFF7F7F7);
const appBarColor = Color(0xFFF7F7F7);
const bottomBarColor = Colors.white;
const inActiveColor = Colors.grey;
const shadowColor = Colors.black87;
const textBoxColor = Colors.white;
const textColor = Color(0xFF333333);
const labelColor = Color(0xFF8A8989);

const actionColor = Color(0xFFe54140);
const buttonColor = Color(0xFFcdacf9);
const cardColor = Colors.white;

const yellow = Color(0xFFffcb66);
const green = Color(0xFFa2e1a6);
const pink = Color(0xFFf5bde8);
const purple = Color(0xFFcdacf9);
const red = Color(0xFFf77080);
const orange = Color(0xFFf5ba92);
const sky = Color(0xFFABDEE6);
const blue = Color(0xFF509BE4);
const cyan = Color(0xFF4ac2dc);
const darkerGreen = Color(0xFFb0d96d);

const listColors = [
  green,
  purple,
  yellow,
  orange,
  sky,
  secondary,
  red,
  blue,
  pink,
  yellow,
];
