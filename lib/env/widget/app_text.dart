import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  const AppText({
    super.key,
    required this.text,
    this.textColor = const Color(0xff000000),
    this.size = 14,
    this.maxLines,
    this.weight = FontWeight.w500,
    this.textAlign = TextAlign.left,
    this.overflow = TextOverflow.ellipsis,
    this.style = FontStyle.normal,
    this.fontFamily,
    this.decoration,
    this.height,
  });

  final String text;
  final Color textColor;
  final double size;
  final int? maxLines;
  final FontWeight weight;
  final TextAlign textAlign;
  final TextOverflow overflow;
  final FontStyle style;
  final String? fontFamily;
  final TextDecoration? decoration;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines ?? 99,
      overflow: overflow,
      style: TextStyle(
        color: textColor,
        fontWeight: weight,
        fontSize: size,
        fontStyle: style,
        decoration: decoration,
        height: height,
      ),
      textAlign: textAlign,
    );
  }

  static Widget ocr({
    required String text,
    Color textColor = const Color(0xff000000),
    double size = 18,
    int? maxLines,
    FontWeight? weight,
    TextAlign? textAlign,
    TextOverflow? overflow,
    FontStyle? style,
    String? fontFamily = 'OCR',
  }) =>
      AppText(
        text: text,
        textColor: textColor,
        size: size,
        maxLines: maxLines,
        weight: weight ?? FontWeight.w500,
        textAlign: textAlign ?? TextAlign.left,
        overflow: overflow ?? TextOverflow.ellipsis,
        style: style ?? FontStyle.normal,
        fontFamily: fontFamily,
      );
}
