import 'package:flutter/material.dart';
import 'package:tandi_mobile/env/class/app_env.dart';
import 'package:tandi_mobile/env/class/app_shortcut.dart';
import 'package:tandi_mobile/env/extension/on_context.dart';
import 'package:tandi_mobile/env/variable/app_constant.dart';
import 'package:tandi_mobile/env/widget/app_text.dart';
import 'package:tandi_mobile/env/widget/ink_material.dart';

class CustomAppBarSearch extends AppBar {
  CustomAppBarSearch({
    Key? key,
    required this.label,
    this.hintText = 'Cari aktifitas',
    PreferredSizeWidget? bottom,
    this.action,
    this.onClose,
    this.onSuffixTap,
    this.onChanged,
    this.withSuffix = true,
  }) : super(key: key, bottom: bottom);
  final String label, hintText;
  final Widget? action;
  final Function()? onClose;
  final Function(String)? onChanged;
  final Function()? onSuffixTap;
  final bool withSuffix;

  @override
  bool get automaticallyImplyLeading => false;

  @override
  Color? get backgroundColor => My.transparent;

  @override
  double? get elevation => 5;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight * 2);

  @override
  Widget? get flexibleSpace => Builder(
        builder: (context) {
          var my = AppShortcut.of(context);

          return Container(
            padding: const EdgeInsets.only(top: 24),
            decoration: const BoxDecoration(
              // color: Color(0xFF1A7F09),
              gradient: LinearGradient(
                colors: [Color(0xFF1A7F09), Color(0xFF82CD47)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              image: DecorationImage(
                image: AssetImage(AppAsset.wave3),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    InkMaterial(
                      onTap: onClose ?? () => context.close(),
                      splashColor: my.color.background.withOpacity(0.1),
                      padding: const EdgeInsets.all(My.padding * 1.25),
                      shapeBorder: const CircleBorder(),
                      child: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    const SizedBox(width: 8),
                    AppText(
                      text: label,
                      textAlign: TextAlign.center,
                      size: 16,
                      weight: FontWeight.w500,
                      textColor: Colors.white,
                    ),
                  ],
                ),
                SearchBar(
                  onSuffixTap: onSuffixTap,
                  withSuffix: withSuffix,
                  hintText: hintText,
                  onChanged: onChanged,
                ),
              ],
            ),
          );
        },
      );
}

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
    required this.onSuffixTap,
    required this.withSuffix,
    required this.hintText,
    required this.onChanged,
  }) : super(key: key);

  final Function()? onSuffixTap;
  final bool withSuffix;
  final String hintText;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 32,
      child: TextFormField(
        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
        onChanged: onChanged,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          focusColor: AppConstant.grey6,
          focusedBorder: _border(AppConstant.grey6),
          border: _border(AppConstant.grey6),
          enabledBorder: _border(AppConstant.grey6),
          hintText: hintText,
          contentPadding: const EdgeInsets.all(4),
          prefixIcon: Image.asset(AppAsset.appbarIconSearch, scale: 2),
          suffixIcon: withSuffix
              ? InkWell(
                  onTap: onSuffixTap,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 30,
                        width: 1,
                        color: My.grey6,
                      ),
                      const SizedBox(width: 6),
                      Image.asset(AppAsset.appbarIconLocation, scale: 1.8),
                      const SizedBox(width: 6),
                      const AppText(
                        text: 'Semua Lokasi',
                        textColor: My.blue2,
                        size: 12,
                        weight: FontWeight.w400,
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                )
              : null,
          hintStyle: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w400,
          ),
          errorStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        onFieldSubmitted: (value) {},
      ),
    );
  }

  OutlineInputBorder _border(Color color) => OutlineInputBorder(
        borderSide: BorderSide(width: 0.5, color: color),
        borderRadius: BorderRadius.circular(8),
      );
}
