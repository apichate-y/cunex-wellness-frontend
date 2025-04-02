// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:cunex_wellness/core/enums/bot_gender.dart';
// import 'package:cunex_wellness/core/services/preferences_manager.dart';

// final botGenderProvider = StateNotifierProvider<BotGenderNotifier, BotGender>((
//   ref,
// ) {
//   return BotGenderNotifier();
// });

// class BotGenderNotifier extends StateNotifier<BotGender> {
//   BotGenderNotifier() : super(BotGender.female) {
//     loadGender();
//   }

//   Future<void> loadGender() async {
//     final gender = await PreferencesManager.loadBotGender();
//     state = gender;
//   }

//   Future<void> selectGender(BotGender gender) async {
//     await PreferencesManager.saveBotGender(gender);
//     state = gender;
//   }
// }
