import 'package:flutter/material.dart';

class MyColors {
  static int _primaryColor = 0xFF1565C0;
  static int _primaryAccentColor = 0xFF1E88E5;
  static int _cardColor = 0xFF4DD0E1;
  static int _cardShadow = 0xFF00BCD4;
  static int _backgroundColor = 0xFFE3F2FD;

  static Color get primaryColor => new Color(_primaryColor);
  static Color get primaryAccentColor => Color(_primaryAccentColor);
  static Color get cardShadow => Color(_cardShadow);
  static Color get cardColor => Color(_cardColor);
  static Color get backgroundColor => Color(_backgroundColor);
}