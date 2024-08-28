// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:tandi_mobile/env/class/app_shortcut.dart';
import 'package:tandi_mobile/env/extension/on_context.dart';
import 'package:tandi_mobile/env/variable/app_constant.dart';
import 'package:tandi_mobile/env/widget/app_text.dart';

class AppConfirmationDialog extends StatelessWidget {
  const AppConfirmationDialog({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onYes,
    required this.onNo,
    this.reversePrio = false,
  });

  final String title, subtitle;
  final Function() onYes, onNo;
  final bool reversePrio;

  @override
  Widget build(BuildContext context) {
    var my = AppShortcut.of(context);

    return AlertDialog(
      title: AppText(
        text: title,
        weight: FontWeight.w600,
        size: 18,
      ),
      content: AppText(
        text: subtitle,
        size: 15,
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () async {
            reversePrio ? await onNo() : await onYes();
            context.close();
          },
          child: AppText(
            text: reversePrio ? 'Tidak' : 'Ya',
            textColor: My.grey,
            weight: FontWeight.w600,
            size: 15,
          ),
        ),
        TextButton(
          onPressed: () async {
            reversePrio ? await onYes() : await onNo();
            context.close();
          },
          child: AppText(
            text: reversePrio ? 'Ya' : 'Tidak',
            textColor: my.color.primary,
            weight: FontWeight.w600,
            size: 15,
          ),
        ),
      ],
    );
  }
}
