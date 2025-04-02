import 'package:cunex_wellness/features/chat_bot/models/bot_message.dart';
import 'package:get/get.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

class ChatController extends GetxController {
  // รายการข้อความในการแชท
  final chatMessages =
      <ChatMessage>[
        ChatMessage(
          text:
              'เฮลโหล~ น้อง Nexky มาแล้ว! พร้อมเป็นเพื่อนคุยคลายเหงา และเติมพลังใจให้เธอนะ!',
          isBot: true,
        ),
      ].obs;

  // ข้อความที่ผู้ใช้กำลังพิมพ์
  final chatInput = ''.obs;

  // Gemini API
  late Gemini gemini;

  @override
  void onInit() {
    super.onInit();
    // เริ่มต้น Gemini API
    gemini = Gemini.init(apiKey: 'AIzaSyCDvOinZEXpKnnRLbMT6O6YS-6DqAv0o64');
  }

  // ส่งข้อความไปยัง Gemini
  Future<void> sendMessage(String text) async {
    // เพิ่มข้อความของผู้ใช้
    final userMessage = ChatMessage(text: text, isBot: false);
    chatMessages.add(userMessage);

    try {
      // ส่งคำขอไปยัง Gemini
      final response = await gemini.prompt(parts: [Part.text(text)]);

      // เพิ่มการตอบกลับจาก bot
      chatMessages.add(
        ChatMessage(
          text:
              response?.output ??
              'น้อง Nekky อยู่ระหว่างพัก ไม่สามารถใช้งานได้ในขณะนี้',
          isBot: true,
        ),
      );
    } catch (e) {
      // จัดการกับข้อผิดพลาด
      chatMessages.add(
        ChatMessage(
          text: 'น้อง Nekky อยู่ระหว่างพัก ไม่สามารถใช้งานได้ในขณะนี้',
          isBot: true,
        ),
      );
    }
  }
}
