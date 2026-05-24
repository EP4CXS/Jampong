import 'package:flutter/material.dart';

class AppShadows {
  const AppShadows._();

  static const List<BoxShadow> soft = [
    BoxShadow(
      color: Color(0x55000000),
      blurRadius: 20,
      offset: Offset(0, 10),
    ),
    BoxShadow(
      color: Color(0x33000000),
      blurRadius: 8,
      offset: Offset(0, 4),
    ),
  ];
}
