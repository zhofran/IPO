import 'package:flutter/material.dart';
import 'package:tandi_mobile/env/widget/app_image.dart';

class ImagesSlider extends StatelessWidget {
  const ImagesSlider({
    super.key,
    required this.images,
    this.isNetwork = false,
  });

  final List<String> images;
  final bool isNetwork;

  @override
  Widget build(BuildContext context) {
    return images.length == 1
        ? AppImage(
            imagePath: images[0],
            height: 130,
            boxFit: BoxFit.cover,
            borderRadius: BorderRadius.zero,
          )
        : SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (int i = 0; i < images.length; i++)
                  Flex(
                    direction: Axis.horizontal,
                    children: [
                      isNetwork
                          ? AppImage(
                              imagePath: images[i],
                              width: 240,
                              height: 130,
                              boxFit: BoxFit.cover,
                              borderRadius: BorderRadius.zero,
                            )
                          : Image.asset(
                              images[i],
                              width: 240,
                              height: 130,
                              fit: BoxFit.cover,
                            ),
                      if (i != images.length - 1) const SizedBox(width: 6)
                    ],
                  ),
              ],
            ),
          );
  }
}
