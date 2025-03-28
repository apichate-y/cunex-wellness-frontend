import 'package:flutter_riverpod/flutter_riverpod.dart';

class QRCodeState extends StateNotifier<String?> {
  QRCodeState() : super(null);

  void setCode(String code) => state = code;
  void clear() => state = null;
}

final qrCodeProvider = StateNotifierProvider<QRCodeState, String?>((ref) {
  return QRCodeState();
});
