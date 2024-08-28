import 'package:flutter/material.dart';
import 'package:tandi_mobile/env/class/app_shortcut.dart';
import 'package:tandi_mobile/env/widget/app_text.dart';

class HorizInformationText extends StatelessWidget {
  const HorizInformationText({
    super.key,
    required this.label,
    required this.content,
  });

  final String label, content;

  @override
  Widget build(BuildContext context) {
    var my = AppShortcut.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(
              width: my.query.size.width * 0.4,
              child: AppText(text: label),
            ),
            const Spacer(),
            SizedBox(
              width: my.query.size.width * 0.5,
              child: AppText(
                text: content,
                weight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
      ],
    );
  }
}
