import 'dart:developer';

import 'package:cunex_wellness/config/color.dart';
import 'package:cunex_wellness/features/calendar/providers/qr_code_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'qr_scanner_overlay.dart';

class QrScanScreen extends ConsumerStatefulWidget {
  const QrScanScreen({super.key});

  @override
  ConsumerState<QrScanScreen> createState() => _QrScanScreenState();
}

class _QrScanScreenState extends ConsumerState<QrScanScreen>
    with WidgetsBindingObserver {
  late MobileScannerController cameraController;
  bool isMounted = true;
  bool cameraInitialized = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    // สร้าง controller ตอน initState และเปิดใช้งานหลังจาก widget ถูกสร้าง
    cameraController = MobileScannerController();

    // เปิดกล้องหลังจาก frame แรกถูกวาด
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (isMounted) {
        initializeCamera();
      }
    });
  }

  Future<void> initializeCamera() async {
    if (!isMounted || cameraInitialized) return;

    try {
      cameraInitialized = true;
      await cameraController.start();
    } catch (e) {
      cameraInitialized = false;
      log("Camera initialization error: $e");
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // ทำให้แน่ใจว่ากล้องเริ่มทำงานหลังจาก widget dependencies พร้อม
    if (!cameraInitialized && isMounted) {
      initializeCamera();
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // จัดการกล้องเมื่อแอปเปลี่ยนสถานะ (เช่น เข้าพื้นหลัง/กลับมาที่หน้าจอ)
    if (!isMounted) return;

    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused) {
      cameraController.stop();
    } else if (state == AppLifecycleState.resumed) {
      if (cameraInitialized) {
        cameraController.start();
      }
    }
  }

  @override
  void dispose() {
    isMounted = false;
    WidgetsBinding.instance.removeObserver(this);

    // ปิดกล้องอย่างปลอดภัย
    try {
      cameraController.stop();
      cameraController.dispose();
    } catch (e) {
      log("Camera disposal error: $e");
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        // ป้องกันการย้อนกลับเมื่อกล้องกำลังทำงาน
        if (didPop) {
          if (cameraInitialized) {
            cameraController.stop();
            cameraInitialized = false;
          }
        } else {
          // หยุดกล้องก่อนย้อนกลับด้วยตัวเอง
          if (cameraInitialized) {
            cameraController.stop();
            cameraInitialized = false;
          }
          if (mounted) {
            Navigator.of(context).pop();
          }
        }
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          final screenHeight = constraints.maxHeight;
          final screenWidth = constraints.maxWidth;

          return Scaffold(
            body: Stack(
              children: [
                // ✅ กล้องสแกนที่มีการจัดการ error
                MobileScanner(
                  controller: cameraController,
                  onDetect: (capture) {
                    if (!isMounted) return;

                    final barcodes = capture.barcodes;
                    if (barcodes.isNotEmpty) {
                      final code = barcodes.first.rawValue;
                      if (code != null && code != ref.read(qrCodeProvider)) {
                        if (!mounted) return;

                        ref.read(qrCodeProvider.notifier).setCode(code);

                        showDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (_) => AlertDialog(
                            title: const Text("QR Code Detected"),
                            content: Text(code),
                            actions: [
                              TextButton(
                                onPressed: () async {
                                  // ปิด dialog ก่อน
                                  Navigator.pop(context);

                                  // หยุดกล้องก่อนย้อนกลับ
                                  if (cameraInitialized) {
                                    await cameraController.stop();
                                    cameraInitialized = false;
                                  }

                                  // ล้างค่า QR code
                                  ref.read(qrCodeProvider.notifier).clear();

                                  // ตรวจสอบว่า widget ยังคงอยู่ก่อน navigate
                                  Future.delayed(Duration(milliseconds: 100),
                                      () {
                                    if (mounted) {
                                      context.pop();
                                    }
                                  });
                                },
                                child: const Text("OK"),
                              ),
                            ],
                          ),
                        );
                      }
                    }
                  },
                  errorBuilder: (context, error, child) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.error, color: Colors.red, size: 36),
                          SizedBox(height: 12),
                          Text(
                            'ไม่สามารถเข้าถึงกล้องได้',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          TextButton(
                            onPressed: () {
                              if (mounted) {
                                Navigator.pop(context);
                              }
                            },
                            child: Text(
                              'กลับ',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    );
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
                          onPressed: () async {
                            // หยุดกล้องก่อนย้อนกลับ
                            if (cameraInitialized) {
                              await cameraController.stop();
                              cameraInitialized = false;
                            }
                            if (mounted) {
                              Navigator.pop(context);
                            }
                          },
                        ),
                      ),

                      // 🖼️ ปุ่มเปิดรูปภาพ
                      Positioned(
                        top: 16,
                        right: 16,
                        child: IconButton(
                          icon: const Icon(Icons.image, color: Colors.white),
                          onPressed: () {
                            // กรณีเว็บ ปิดฟังก์ชันนี้ไว้ก่อน
                            if (!kIsWeb) {
                              // cameraController.pickImage();
                            }
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
                            icon: const Icon(
                              Icons.qr_code,
                              color: Colors.white,
                            ),
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
      ),
    );
  }
}
