import 'package:flutter/material.dart';

part 'themes/light_theme.dart';
part 'themes/dark_theme.dart';

const _fontFamily = 'Montserrat';

class AppTheme {
  static ThemeData get lightTheme => _lightTheme;
  static ThemeData get darkTheme => _darkTheme;
}
