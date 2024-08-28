import 'package:flutter/material.dart';
import 'package:tandi_mobile/env/class/app_shortcut.dart';
import 'package:tandi_mobile/env/variable/app_constant.dart';
import 'package:tandi_mobile/env/widget/app_text.dart';

class AppChip extends StatelessWidget {
  const AppChip({
    super.key,
    required this.label,
    required this.status,
    required this.onTap,
    this.isWrap = false,
  });

  final List<String> label;
  final List<bool> status;
  final Function(int) onTap;
  final bool isWrap;

  @override
  Widget build(BuildContext context) {
    var my = AppShortcut.of(context);

    return isWrap
        ? Wrap(
            children: [...chipWrapChild(my)],
          )
        : SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              children: [
                ...chipScrollChild(my),
              ],
            ),
          );
  }

  List<Widget> chipWrapChild(AppShortcut my) {
    return List.generate(
      label.length,
      (i) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(15),
                onTap: () => onTap(i),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                  decoration: BoxDecoration(
                    color:
                        status[i] ? My.green2.withOpacity(0.19) : Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                        color: status[i] ? my.color.primary : My.grey6),
                  ),
                  child: AppText(
                    text: label[i],
                    size: 12,
                    textColor: status[i] ? my.color.primary : My.grey6,
                  ),
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  List<Widget> chipScrollChild(AppShortcut my) {
    return List.generate(
      label.length,
      (i) => Flex(
        direction: Axis.horizontal,
        children: [
          if (i == 0) const SizedBox(width: 16),
          InkWell(
            borderRadius: BorderRadius.circular(15),
            onTap: () => onTap(i),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
              decoration: BoxDecoration(
                color: status[i] ? My.green2.withOpacity(0.19) : Colors.white,
                borderRadius: BorderRadius.circular(15),
                border:
                    Border.all(color: status[i] ? my.color.primary : My.grey6),
              ),
              child: AppText(
                text: label[i],
                size: 12,
                textColor: status[i] ? my.color.primary : My.grey6,
              ),
            ),
          ),
          (i == label.length - 1)
              ? const SizedBox(width: 16)
              : const SizedBox(width: 8),
        ],
      ),
    );
  }
}
