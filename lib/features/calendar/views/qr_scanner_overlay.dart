import 'package:flutter/material.dart';

class QRScannerOverlay extends StatelessWidget {
  const QRScannerOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _QRScannerOverlayPainter(),
      size: Size.infinite,
    );
  }
}

class _QRScannerOverlayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const double borderRadius = 16;
    const double overlaySize = 250;
    final Paint paint = Paint()
      ..color = Colors.black.withOpacity(0.6);

    // มืดพื้นหลัง
    canvas.drawRect(Offset.zero & size, paint);

    // กรอบโปร่งกลางจอ
    final double left = (size.width - overlaySize) / 2;
    final double top = (size.height - overlaySize) / 2 - 100;
    final RRect hole = RRect.fromRectAndRadius(
      Rect.fromLTWH(left, top, overlaySize, overlaySize),
      const Radius.circular(borderRadius),
    );

    canvas.saveLayer(Offset.zero & size, Paint());
    paint.blendMode = BlendMode.clear;
    canvas.drawRRect(hole, paint);
    canvas.restore();

    // เส้นมุม
    final Paint borderPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    const double cornerLength = 30;
    final double right = left + overlaySize;
    final double bottom = top + overlaySize;

    // มุมซ้ายบน
    canvas.drawLine(Offset(left, top), Offset(left + cornerLength, top), borderPaint);
    canvas.drawLine(Offset(left, top), Offset(left, top + cornerLength), borderPaint);

    // มุมขวาบน
    canvas.drawLine(Offset(right, top), Offset(right - cornerLength, top), borderPaint);
    canvas.drawLine(Offset(right, top), Offset(right, top + cornerLength), borderPaint);

    // มุมซ้ายล่าง
    canvas.drawLine(Offset(left, bottom), Offset(left + cornerLength, bottom), borderPaint);
    canvas.drawLine(Offset(left, bottom), Offset(left, bottom - cornerLength), borderPaint);

    // มุมขวาล่าง
    canvas.drawLine(Offset(right, bottom), Offset(right - cornerLength, bottom), borderPaint);
    canvas.drawLine(Offset(right, bottom), Offset(right, bottom - cornerLength), borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
