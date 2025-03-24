import 'package:cunex_wellness/core/enums/bot_gender.dart';
import 'package:shared_preferences/shared_preferences.dart';

// คลาสสำหรับจัดการการตั้งค่าในแอพ
class PreferencesManager {
  static const String _botGenderKey = 'bot_gender';
  
  // บันทึกเพศของบอท
  static Future<void> saveBotGender(BotGender gender) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_botGenderKey, gender.index);
  }
  
  // โหลดเพศของบอทที่บันทึกไว้
  static Future<BotGender> loadBotGender() async {
    final prefs = await SharedPreferences.getInstance();
    final genderIndex = prefs.getInt(_botGenderKey);
    
    if (genderIndex != null) {
      return BotGender.values[genderIndex];
    }
    
    // ถ้าไม่มีข้อมูลที่บันทึกไว้ ให้ใช้ค่าเริ่มต้น
    return BotGender.other;
  }
}