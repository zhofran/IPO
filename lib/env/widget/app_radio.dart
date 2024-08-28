import 'package:flutter/material.dart';
import 'package:tandi_mobile/env/class/app_shortcut.dart';
import 'package:tandi_mobile/env/variable/app_constant.dart';
import 'package:tandi_mobile/env/widget/app_text.dart';

class AppRadio extends StatelessWidget {
  const AppRadio({
    super.key,
    required this.label,
    required this.status,
    required this.onTap,
  });

  final List<String> label;
  final List<bool> status;
  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    var my = AppShortcut.of(context);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          ...radioScrollChild(my),
        ],
      ),
    );
  }

  List<Widget> radioScrollChild(AppShortcut my) {
    return List.generate(
      label.length,
      (i) => Flex(
        direction: Axis.horizontal,
        children: [
          InkWell(
            onTap: () => onTap(i),
            child: Flex(
              direction: Axis.horizontal,
              children: [
                Icon(
                  status[i]
                      ? Icons.radio_button_checked
                      : Icons.radio_button_off,
                  size: 16,
                  color: status[i] ? my.color.primary : My.grey6,
                ),
                const SizedBox(width: 4),
                AppText(
                  text: label[i],
                  size: 12,
                  textColor: status[i] ? my.color.primary : Colors.black,
                ),
              ],
            ),
          ),
          if (i != label.length - 1) const SizedBox(width: 16)
        ],
      ),
    );
  }
}
