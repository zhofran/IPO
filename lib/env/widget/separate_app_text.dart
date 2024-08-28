import 'package:flutter/material.dart';
import 'package:tandi_mobile/env/class/app_shortcut.dart';
import 'package:tandi_mobile/env/variable/app_constant.dart';
import 'package:tandi_mobile/env/widget/app_text.dart';

class SeparateAppText extends StatelessWidget {
  const SeparateAppText({
    super.key,
    required this.leftText,
    required this.rightText,
    this.additionalWidget,
  });

  final String leftText, rightText;
  final Widget? additionalWidget;

  @override
  Widget build(BuildContext context) {
    var my = AppShortcut.of(context);

    return SizedBox(
      width: my.query.size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              AppText(
                text: leftText,
                weight: FontWeight.w600,
                textColor: My.grey2,
              ),
              if (additionalWidget != null) const SizedBox(width: 4),
              if (additionalWidget != null) additionalWidget!,
            ],
          ),
          AppText(
            text: rightText,
            weight: FontWeight.w600,
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
