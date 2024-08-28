import 'package:flutter/material.dart';
import 'package:tandi_mobile/env/class/app_shortcut.dart';
import 'package:tandi_mobile/env/extension/on_context.dart';
import 'package:tandi_mobile/env/variable/app_constant.dart';
import 'package:tandi_mobile/env/widget/app_image.dart';
import 'package:tandi_mobile/env/widget/app_text.dart';

class TransactionHistoryShortcutCard extends StatelessWidget {
  const TransactionHistoryShortcutCard({
    super.key,
    required this.receiveNumber,
    required this.category,
    required this.name,
    required this.onTap,
    required this.imagePath,
    this.width,
  });

  final String receiveNumber, category, name, imagePath;
  final double? width;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    var my = AppShortcut.of(context);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: my.color.primary.withOpacity(0.5),
        ),
      ),
      width: width ?? my.query.size.width,
      margin: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.white,
                child: AppImage(
                  imagePath: imagePath,
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: my.query.size.width * 0.7,
                child: context.responsive(
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        text: receiveNumber,
                        size: 15,
                        weight: FontWeight.w600,
                      ),
                      const SizedBox(height: 2),
                      AppText(
                        text: '$category - $name',
                        textColor: My.grey,
                        weight: FontWeight.w600,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
