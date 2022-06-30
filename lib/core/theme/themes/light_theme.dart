part of '../app_theme.dart';

final _lightTheme = ThemeData(
  splashColor: Colors.blue.withOpacity(.5),
  highlightColor: Colors.blue.withOpacity(.1),
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white,
  fontFamily: _fontFamily,
  primaryColor: Colors.blue,
  textTheme: const TextTheme(
    headline6: TextStyle(
      fontSize: 16,
      decoration: TextDecoration.none,
    ),
    button: TextStyle(
      fontWeight: FontWeight.bold,
    ),
  ),
  tabBarTheme: TabBarTheme(
    labelColor: Colors.blue,
    unselectedLabelColor: Colors.grey[600],
    labelStyle: const TextStyle(fontFamily: _fontFamily, fontWeight: FontWeight.bold),
    unselectedLabelStyle: const TextStyle(fontFamily: _fontFamily, fontWeight: FontWeight.bold),
  ),
  appBarTheme: const AppBarTheme(
    color: Colors.white,
    actionsIconTheme: IconThemeData(color: Colors.blue),
    iconTheme: IconThemeData(color: Colors.blue),
    titleTextStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16, fontFamily: _fontFamily),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: Colors.blue,
    unselectedItemColor: Colors.grey,
    // backgroundColor: Colors.transparent,
    //showUnselectedLabels: true,
    type: BottomNavigationBarType.fixed,
    unselectedLabelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
    selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    extendedTextStyle: TextStyle(
      fontWeight: FontWeight.bold,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    isDense: true,
    //contentPadding: const EdgeInsets.all(kSidePadding12),
    filled: true,
    fillColor: Colors.blueGrey.withAlpha(10),
    isCollapsed: true,
    hintStyle: const TextStyle(height: 1),
    // constraints: const BoxConstraints.tightFor(height: kButtonHeight),
  ),
  // buttonTheme: ButtonThemeData(
  // shape: RoundedRectangleBorder(
  //   borderRadius: BorderRadius.circular(18.0),
  //   side: BorderSide.none,
  // ),
  // ),
  // elevatedButtonTheme: ElevatedButtonThemeData(
  //   style: ButtonStyle(
  //     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
  //       RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(18.0),
  //         side: BorderSide.none,
  //       ),
  //     ),
  //     minimumSize: MaterialStateProperty.all<Size>(const Size(double.minPositive, kButtonHeight)),
  // padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
  //   const EdgeInsets.all(10),
  // ),
  // ),
  // ),
);
