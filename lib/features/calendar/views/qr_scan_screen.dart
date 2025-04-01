import 'package:cunex_wellness/config/color.dart';
import 'package:cunex_wellness/features/calendar/providers/qr_code_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'qr_scanner_overlay.dart';

class QrScanScreen extends ConsumerStatefulWidget {
  const QrScanScreen({super.key});

  @override
  ConsumerState<QrScanScreen> createState() => _QrScanScreenState();
}

class _QrScanScreenState extends ConsumerState<QrScanScreen> {
  final MobileScannerController cameraController = MobileScannerController();

  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(
      builder: (context, constraints) {
        final screenHeight = constraints.maxHeight;
        final screenWidth = constraints.maxWidth;

        return Scaffold(
          body: Stack(
            children: [
              // ✅ กล้องสแกน
              MobileScanner(
                controller: cameraController,
                onDetect: (capture) {
                  final barcodes = capture.barcodes;
                  if (barcodes.isNotEmpty) {
                    final code = barcodes.first.rawValue;
                    if (code != null && code != ref.read(qrCodeProvider)) {
                      ref.read(qrCodeProvider.notifier).setCode(code);

                      showDialog(
                        context: context,
                        builder:
                            (_) => AlertDialog(
                              title: const Text("QR Code Detected"),
                              content: Text(code),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    ref.read(qrCodeProvider.notifier).clear();
                                  },
                                  child: const Text("OK"),
                                ),
                              ],
                            ),
                      );
                    }
                  }
                },
              ),

              // ✅ ไกด์ไลน์ตรงกลาง
              const QRScannerOverlay(),

              // ✅ UI ซ้อน SafeArea
              SafeArea(
                child: Stack(
                  children: [
                    // ❌ ปุ่มปิด (X)
                    Positioned(
                      top: 16,
                      left: 16,
                      child: IconButton(
                        icon: const Icon(Icons.close, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),

                    // 🖼️ ปุ่มเปิดรูปภาพ
                    Positioned(
                      top: 16,
                      right: 16,
                      child: IconButton(
                        icon: const Icon(Icons.image, color: Colors.white),
                        onPressed: () {
                          // cameraController.pickImage();
                        },
                      ),
                    ),

                    // ✅ ปุ่ม My QR code (responsive)
                    Positioned(
                      bottom: screenHeight * 0.28,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.qr_code, color: Colors.white),
                          label: const Text(
                            'My QR code',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.rosePink,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 24,
                            ),
                          ),
                          onPressed: () {
                            // ไปหน้า QR Code ของเรา
                          },
                        ),
                      ),
                    ),

                    // ✅ กล่องค้นหา + หัวข้อ
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: screenHeight * 0.23,
                        width: screenWidth,
                        padding: EdgeInsets.fromLTRB(
                          16,
                          16,
                          16,
                          screenHeight < 600 ? 16 : 24,
                        ), // responsive padding
                        color: Colors.white,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Scan QR code to add friend',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(32),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: AppTheme.rosePink,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.search,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  const Expanded(
                                    child: TextField(
                                      style: TextStyle(fontSize: 16),
                                      decoration: InputDecoration(
                                        hintText: "Search...",
                                        border: InputBorder.none,
                                        isDense: true,
                                        contentPadding: EdgeInsets.zero,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
