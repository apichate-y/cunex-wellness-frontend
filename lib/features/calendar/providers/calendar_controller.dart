import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CalendarController extends GetxController {
  // state variables
  final selectedDay = Rx<DateTime?>(DateTime.now());
  final focusedDay = DateTime.now().obs;
  final showNote = false.obs;
  final noteText = "".obs;
  final imageList = <XFile>[].obs;
  final selectedMood = Rx<int?>(null);
  final panelPosition = 0.0.obs;

  // mood data
  final moodData =
      {
        DateTime.utc(2025, 2, 3): 0,
        DateTime.utc(2025, 2, 4): 1,
        DateTime.utc(2025, 2, 6): 2,
        DateTime.utc(2025, 2, 7): 3,
        DateTime.utc(2025, 2, 12): 4,
        DateTime.utc(2025, 2, 13): 5,
        DateTime.utc(2025, 2, 14): 0,
        DateTime.utc(2025, 2, 17): 2,
      }.obs;

  final moodImages = [
    'lib/assets/images/icons/เมฆ emotion/Untitled-24-07.png',
    'lib/assets/images/icons/เมฆ emotion/Untitled-24-08.png',
    'lib/assets/images/icons/เมฆ emotion/Untitled-24-09.png',
    'lib/assets/images/icons/เมฆ emotion/Untitled-24-10.png',
    'lib/assets/images/icons/เมฆ emotion/Untitled-24-11.png',
    'lib/assets/images/icons/เมฆ emotion/Untitled-24-12.png',
  ];

  void setMood(DateTime date, int moodIndex) {
    final key = DateTime.utc(date.year, date.month, date.day);
    final updatedData = {...moodData};
    updatedData[key] = moodIndex;
    moodData.value = updatedData;
  }

  Future<void> pickImages() async {
    final picker = ImagePicker();
    final pickedFiles = await picker.pickMultiImage();
    if (pickedFiles != null && pickedFiles.isNotEmpty) {
      final updated = [...imageList, ...pickedFiles].take(9).toList();
      imageList.value = updated;
    }
  }

  void resetToToday() {
    final now = DateTime.now();
    selectedDay.value = now;
    focusedDay.value = now;
    selectedMood.value = null;
    imageList.clear();
    noteText.value = "";
  }

  void onDaySelected(DateTime selected, DateTime focused) {
    selectedDay.value = selected;
    focusedDay.value = focused;
    selectedMood.value = null;
    imageList.clear();
    noteText.value = "";
  }
}
