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
    // ลบ borderRadius ออกให้เป็นสี่เหลี่ยมจัตุรัส
    const double overlaySize = 250;
    final Paint paint = Paint()..color = Colors.black.withOpacity(0.6);

    final double left = (size.width - overlaySize) / 2;
    final double top = (size.height - overlaySize) / 2 - 100;
    final double right = left + overlaySize;
    final double bottom = top + overlaySize;

    // วาดพื้นหลังสี่เหลี่ยมทั้ง 4 ด้าน
    // ด้านบน
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, top),
      paint,
    );
    
    // ด้านซ้าย
    canvas.drawRect(
      Rect.fromLTWH(0, top, left, overlaySize),
      paint,
    );
    
    // ด้านขวา
    canvas.drawRect(
      Rect.fromLTWH(right, top, size.width - right, overlaySize),
      paint,
    );
    
    // ด้านล่าง
    canvas.drawRect(
      Rect.fromLTWH(0, bottom, size.width, size.height - bottom),
      paint,
    );

    // วาดเส้นขอบสี่เหลี่ยม
    final Paint borderPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;
      
    // เปลี่ยนจาก RRect เป็น Rect ธรรมดา
    final Rect borderRect = Rect.fromLTWH(left, top, overlaySize, overlaySize);
    
    canvas.drawRect(borderRect, borderPaint);

    const double cornerLength = 30;

    // มุมซ้ายบน
    canvas.drawLine(Offset(left, top + cornerLength), Offset(left, top), borderPaint);
    canvas.drawLine(Offset(left, top), Offset(left + cornerLength, top), borderPaint);

    // มุมขวาบน
    canvas.drawLine(Offset(right - cornerLength, top), Offset(right, top), borderPaint);
    canvas.drawLine(Offset(right, top), Offset(right, top + cornerLength), borderPaint);

    // มุมซ้ายล่าง
    canvas.drawLine(Offset(left, bottom - cornerLength), Offset(left, bottom), borderPaint);
    canvas.drawLine(Offset(left, bottom), Offset(left + cornerLength, bottom), borderPaint);

    // มุมขวาล่าง
    canvas.drawLine(Offset(right - cornerLength, bottom), Offset(right, bottom), borderPaint);
    canvas.drawLine(Offset(right, bottom), Offset(right, bottom - cornerLength), borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}