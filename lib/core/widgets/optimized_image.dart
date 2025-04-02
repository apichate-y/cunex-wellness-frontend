import 'package:flutter/material.dart';

class OptimizedImage extends StatelessWidget {
  final String assetPath;
  final double? scale;
  final double? height;
  final double? width;
  final Color? color;
  final BoxFit fit;

  const OptimizedImage({
    super.key,
    required this.assetPath,
    this.scale,
    this.height,
    this.width,
    this.color,
    this.fit = BoxFit.contain,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      assetPath,
      scale: scale,
      height: height,
      width: width,
      fit: fit,
      cacheHeight: height != null ? (height! * 1.5).toInt() : null,
      cacheWidth: width != null ? (width! * 1.5).toInt() : null,
      // เพิ่ม parameters เพื่อลดการใช้หน่วยความจำ
      gaplessPlayback: true,
      filterQuality: FilterQuality.medium,
      color: color,
    );
  }
}
