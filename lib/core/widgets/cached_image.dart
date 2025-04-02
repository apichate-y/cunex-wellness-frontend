import 'package:cunex_wellness/core/controllers/image_cache_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CachedImage extends StatelessWidget {
  final String imagePath;
  final double? width;
  final double? height;
  final Color? color;
  final BoxFit fit;
  final Function()? onTap;

  const CachedImage({
    super.key,
    required this.imagePath,
    this.width,
    this.height,
    this.color,
    this.fit = BoxFit.contain,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ImageCacheController>();

    Widget imageWidget = Obx(() {
      if (!controller.isInitialized.value) {
        return Container(width: width, height: height, color: Colors.grey[300]);
      }

      return Image(
        image: controller.getImageProvider(imagePath),
        width: width,
        height: height,
        color: color,
        fit: fit,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(imagePath, width: width, height: height, fit: fit);
        },
      );
    });

    if (onTap != null) {
      return GestureDetector(onTap: onTap, child: imageWidget);
    }

    return imageWidget;
  }
}
