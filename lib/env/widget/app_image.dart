import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tandi_mobile/env/class/app_env.dart';

class AppImage extends StatelessWidget {
  const AppImage({
    super.key,
    required this.imagePath,
    this.height,
    this.width,
    this.borderRadius,
    this.radius = 8,
    this.boxFit = BoxFit.cover,
  });

  final String imagePath;
  final BorderRadius? borderRadius;
  final double? height, width, radius;
  final BoxFit? boxFit;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(radius!),
      child: CachedNetworkImage(
        imageUrl: imagePath,
        fit: boxFit,
        height: height ?? MediaQuery.of(context).size.height,
        width: width ?? MediaQuery.of(context).size.width,
        placeholder: (_, ___) => SizedBox(
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade200,
            child: const ColoredBox(color: Colors.white),
          ),
        ),
        errorWidget: (_, __, ___) {
          return Image.network(
            AppAsset.imageNetworkPlaceholder,
            width: width ?? MediaQuery.of(context).size.width,
            height: height,
            fit: BoxFit.cover,
          );
        },
      ),
    );
  }
}

class AppImageAsset extends StatelessWidget {
  const AppImageAsset({
    super.key,
    required this.imagePath,
    this.height,
    this.width,
    this.radius = 8,
    this.fit = BoxFit.cover,
  });

  final String imagePath;
  final double radius;
  final double? height, width;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Image.asset(
        imagePath,
        height: height ?? MediaQuery.of(context).size.height,
        width: width ?? MediaQuery.of(context).size.width,
        fit: fit,
      ),
    );
  }
}
