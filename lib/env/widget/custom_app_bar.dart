import 'package:flutter/material.dart';
import 'package:tandi_mobile/env/class/app_shortcut.dart';
import 'package:tandi_mobile/env/extension/on_context.dart';
import 'package:tandi_mobile/env/variable/app_constant.dart';
import 'package:tandi_mobile/env/widget/app_text.dart';
import 'package:tandi_mobile/env/widget/ink_material.dart';

class CustomAppBar extends AppBar {
  CustomAppBar({
    Key? key,
    required this.label,
    PreferredSizeWidget? bottom,
    this.action,
    this.onClose,
  }) : super(key: key, bottom: bottom);
  final String label;
  final Widget? action;
  final Function()? onClose;

  @override
  bool get automaticallyImplyLeading => false;

  @override
  Color? get backgroundColor => My.transparent;

  @override
  double? get elevation => 5;

  @override
  Widget? get flexibleSpace => Builder(
        builder: (context) {
          var my = AppShortcut.of(context);

          return Container(
            padding: const EdgeInsets.only(top: 24),
            height: kToolbarHeight * 2,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1A7F09), Color(0xFF82CD47)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  left: 0,
                  bottom: -1,
                  child: InkMaterial(
                    onTap: onClose ?? () => context.close(),
                    splashColor: my.color.background.withOpacity(0.1),
                    padding: const EdgeInsets.all(My.padding * 1.25),
                    shapeBorder: const CircleBorder(),
                    child: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                ),
                if (action != null)
                  Positioned(
                    right: 16,
                    child: action!,
                  ),
                AppText(
                  text: label,
                  textAlign: TextAlign.center,
                  size: 16,
                  weight: FontWeight.w500,
                  textColor: Colors.white,
                ),
              ],
            ),
          );
        },
      );
}
