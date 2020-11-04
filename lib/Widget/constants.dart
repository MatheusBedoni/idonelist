
import 'package:flutter/material.dart';

class Contants{
  static final Color backgroundColor = Color(0xFFB7B3FC);
  static final String idAppAdmob = 'ca-app-pub-7179823338376407~6624646779';
  static final String idIntersAdmob = 'ca-app-pub-7179823338376407/8504048119';
  static final Color sombraColor = Color(0xFFC6A2F8);
  static final Color textColor = Color(0xFF707070);
  static final String fontFamily = 'JosefinSlab';
  static final int fontSize = 35;
  static final BoxDecoration decorationBackground = BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Contants.backgroundColor,
        Contants.backgroundColor.withOpacity(0.6),
      ],
    ),
  );

}