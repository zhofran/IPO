import 'package:flutter/material.dart';
import 'package:tandi_mobile/env/class/app_shortcut.dart';
import 'package:tandi_mobile/env/extension/on_context.dart';
import 'package:tandi_mobile/env/widget/app_text.dart';

class AppButtonIcon extends StatelessWidget {
  const AppButtonIcon({
    super.key,
    required this.title,
    required this.image,
    required this.onTap,
    this.width,
    this.color,
  });

  final String title, image;
  final Function() onTap;
  final double? width;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    var my = AppShortcut.of(context);

    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: my.color.primary.withOpacity(1),
          ),
        ),
        height: 50,
        width: width ?? my.query.size.width / 2 - 24,
        child: context.responsive(
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(image, scale: 2, color: color),
              const SizedBox(width: 8),
              AppText(
                text: title,
                textColor: my.color.primary,
              )
            ],
          ),
        ),
      ),
    );
  }
}
