import 'package:flutter/material.dart';
import 'package:tandi_mobile/env/class/app_shortcut.dart';
import 'package:tandi_mobile/env/widget/app_text.dart';

class AppIconImage extends StatelessWidget {
  const AppIconImage({
    super.key,
    required this.image,
    required this.label,
    required this.onTap,
    this.color,
    this.weight,
    this.width = 36,
    this.height = 36,
  });

  final String image, label;
  final Color? color;
  final double width, height;
  final Function() onTap;
  final FontWeight? weight;

  @override
  Widget build(BuildContext context) {
    var my = AppShortcut.of(context);

    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: my.query.size.width * 0.21,
        child: Column(
          children: [
            Image.asset(
              image,
              color: color,
              width: width,
              height: height,
            ),
            // Icon(Icons.home, size: 22),
            const SizedBox(height: 8),
            AppText(
              text: label,
              size: 13,
              textAlign: TextAlign.center,
              weight: weight ?? FontWeight.w500,
            )
          ],
        ),
      ),
    );
  }
}
