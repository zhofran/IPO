import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tandi_mobile/env/extension/on_context.dart';

class AppImageCircular extends StatelessWidget {
  const AppImageCircular({
    super.key,
    required this.imageUrl,
    this.size = 52,
    this.isWithAdditional,
    this.isLocal,
    this.fileLocal,
  });

  final String imageUrl;
  final double size;
  final Function()? isWithAdditional;
  final bool? isLocal;
  final File? fileLocal;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: SizedBox.fromSize(
        size: Size.fromRadius(size),
        child: GestureDetector(
          onTap: isWithAdditional ??
              () {
                context.show(
                  child: AlertDialog(
                    contentPadding: const EdgeInsets.all(0),
                    content: isLocal == true
                        ? Image.file(fileLocal!, fit: BoxFit.cover)
                        : Image.network(imageUrl, fit: BoxFit.cover),
                  ),
                );
              },
          child: isLocal == true
              ? Image.file(fileLocal!, fit: BoxFit.cover)
              : Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) {
                    return ClipOval(
                      child: SizedBox.fromSize(
                        size: Size.fromRadius(size),
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade200,
                          child: const ColoredBox(color: Colors.white),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
