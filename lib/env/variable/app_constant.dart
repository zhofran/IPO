import 'package:flutter/material.dart';

typedef My = AppConstant;

class AppConstant {
  // Value variable
  static const double serviceFee = 1000.0;

  // Value Shortcuts
  static const double padding = 15.0;
  static const double radius = 7.5;
  static const double buttonHeight = 50.0;
  static const double buttonTextSize = 16.0;
  static const double titleTextSize = 18.0;

  // Value Color
  static const Color black = Color(0xFF1E1E1E);
  static const Color softRed = Color(0xFFC53F3F);

  static const Color grey = Color(0xFF747474);
  static const Color grey2 = Color(0xff696969);
  static Color grey3 = const Color(0xffEBEFF3).withOpacity(0.5);
  static Color grey4 = const Color(0xff919191).withOpacity(0.5);
  static Color grey5 = const Color(0xffF0F0F0);
  static Color grey6 = const Color(0xff919191);
  static Color grey7 = const Color(0xff3A3A3A).withOpacity(0.75);
  static Color grey8 = const Color(0xffD9D9D9).withOpacity(0.35);
  static Color grey9 = const Color(0xff5D5D5D);
  static Color grey10 = const Color(0xffD9D9D9);

  static const Color blue = Color(0xff57B7EB);
  static const Color blue2 = Color(0xff1895E1);

  static const Color green = Color(0xff0ED290);
  static const Color green2 = Color(0xff82CD47);
  static Color green3 = const Color(0xff82CD47).withOpacity(0.5);
  static const Color green4 = Color(0xff009951);

  static const Color primaryWithOpacity = Color.fromRGBO(171, 9, 0, 0.1);
  static Color primaryGradient = const Color(0xff82CD47).withOpacity(0.5);

  // Linear Gradient
  static const Color gradientGreen1 = Color(0xFF1A7F09);
  static Color gradientGreen2 = const Color(0xFF82CD47).withOpacity(0.5);

  // Etc
  static const String lipsum =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.";
  static const Color transparent = Colors.transparent;
  static const Duration duration = Duration(milliseconds: 300);
  static Future delayed = Future.delayed(duration);
  static const Curve curve = Curves.easeIn;
  static const Duration timeout = Duration(minutes: 1);
  static const Duration alertDuration = Duration(milliseconds: 2000);
  static DateTime initialDate = DateTime(2022, 01, 01);
  static const productId = "3ba5c6bd-f8af-4db8-a5d3-8be7b00853bl";
  static const productIdV = "1840bb72-10fb-40f0-9f86-c36644bde27e";
}
