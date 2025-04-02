import 'dart:io';

import 'package:cunex_wellness/config/color.dart';
import 'package:cunex_wellness/core/widgets/optimized_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

final moodDataProvider =
    StateNotifierProvider<MoodDataNotifier, Map<DateTime, int>>((ref) {
      return MoodDataNotifier();
    });

class MoodDataNotifier extends StateNotifier<Map<DateTime, int>> {
  MoodDataNotifier()
    : super({
        DateTime.utc(2025, 2, 3): 0,
        DateTime.utc(2025, 2, 4): 1,
        DateTime.utc(2025, 2, 6): 2,
        DateTime.utc(2025, 2, 7): 3,
        DateTime.utc(2025, 2, 12): 4,
        DateTime.utc(2025, 2, 13): 5,
        DateTime.utc(2025, 2, 14): 0,
        DateTime.utc(2025, 2, 17): 2,
      });

  void setMood(DateTime date, int moodIndex) {
    final key = DateTime.utc(date.year, date.month, date.day);
    state = {...state, key: moodIndex};
  }
}

final moodImages = [
  'lib/assets/images/icons/เมฆ emotion/Untitled-24-07.png',
  'lib/assets/images/icons/เมฆ emotion/Untitled-24-08.png',
  'lib/assets/images/icons/เมฆ emotion/Untitled-24-09.png',
  'lib/assets/images/icons/เมฆ emotion/Untitled-24-10.png',
  'lib/assets/images/icons/เมฆ emotion/Untitled-24-11.png',
  'lib/assets/images/icons/เมฆ emotion/Untitled-24-12.png',
];

final selectedDayProvider = StateProvider<DateTime?>((ref) => DateTime.now());
final focusedDayProvider = StateProvider<DateTime>((ref) => DateTime.now());
final showNoteProvider = StateProvider<bool>((ref) => false);
final noteTextProvider = StateProvider<String>((ref) => "");

final imageListProvider = StateProvider<List<XFile>>((ref) => []);
final selectedMoodProvider = StateProvider<int?>((ref) => null);
final panelPositionProvider = StateProvider<double>((ref) => 0);

class CalendarScreen extends ConsumerStatefulWidget {
  const CalendarScreen({super.key});

  @override
  ConsumerState<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends ConsumerState<CalendarScreen> {
  final TextEditingController noteController = TextEditingController();
  final panelController = PanelController();
  final moodImages = [
    'lib/assets/images/icons/เมฆ emotion/Untitled-24-07.png',
    'lib/assets/images/icons/เมฆ emotion/Untitled-24-08.png',
    'lib/assets/images/icons/เมฆ emotion/Untitled-24-09.png',
    'lib/assets/images/icons/เมฆ emotion/Untitled-24-10.png',
    'lib/assets/images/icons/เมฆ emotion/Untitled-24-11.png',
    'lib/assets/images/icons/เมฆ emotion/Untitled-24-12.png',
  ];

  Future<void> pickImages() async {
    final picker = ImagePicker();
    final pickedFiles = await picker.pickMultiImage();
    if (pickedFiles != null && pickedFiles.isNotEmpty) {
      final currentImages = ref.read(imageListProvider);
      final updated = [...currentImages, ...pickedFiles].take(9).toList();
      ref.read(imageListProvider.notifier).state = updated;
    }
  }

  List<Widget> _buildMoodSelector(double iconSize) {
    return List.generate(6, (index) {
      return GestureDetector(
        onTap: () {
          ref.read(selectedMoodProvider.notifier).state = index;
        },
        child: SizedBox(
          width: iconSize,
          height: iconSize,
          child: FittedBox(
            fit: BoxFit.contain,
            child: Image.asset(moodImages[index]),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedDay = ref.watch(selectedDayProvider);
    final focusedDay = ref.watch(focusedDayProvider);
    final moodData = ref.watch(moodDataProvider);
    final images = ref.watch(imageListProvider);
    final selectedMood = ref.watch(selectedMoodProvider);
    final panelPosition = ref.watch(panelPositionProvider);

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final iconSize = screenWidth * 0.14;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SlidingUpPanel(
          controller: panelController,
          color: AppTheme.greyUltraLight,
          minHeight: screenHeight * 0.40,
          maxHeight: screenHeight * 0.85,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
          onPanelSlide: (position) {
            ref.read(panelPositionProvider.notifier).state = position;
          },
          panel: Padding(
            padding: EdgeInsets.symmetric(
              vertical: screenWidth * 0.04,
              horizontal: screenWidth * 0.06,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (selectedMood == null) ...[
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 3,
                      crossAxisSpacing: screenWidth * 0.04,
                      mainAxisSpacing: screenWidth * 0.04,
                      children: _buildMoodSelector(iconSize),
                    ),
                  ] else ...[
                    if (panelPosition > 0.95)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: CircleAvatar(
                                radius: 20,
                                backgroundImage: AssetImage(
                                  'lib/assets/images/element/j.png',
                                ),
                              ),
                            ),

                            Align(
                              alignment: Alignment.center,
                              child: DropdownButton<String>(
                                items: const [
                                  DropdownMenuItem(
                                    value: 'everyone',
                                    child: Text('Everyone'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'add',
                                    child: Row(
                                      children: [
                                        Icon(Icons.add),
                                        SizedBox(width: 4),
                                        Text('add friend'),
                                      ],
                                    ),
                                  ),
                                ],
                                onChanged: (value) {
                                  if (value == "add") {
                                    context.push('/qr-scan');
                                  }
                                },
                                value: 'everyone',
                              ),
                            ),
                          ],
                        ),
                      ),
                    const Text(
                      'วันนี้เป็นยังไงบ้าง เล่าให้ฟังหน่อยสิ',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppTheme.rosePink,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: noteController,
                      minLines: 4,
                      maxLines: 6,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppTheme.rosePink,
                        hintText: "add note...",
                        hintStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: images.length < 9 ? images.length + 1 : 9,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                            childAspectRatio: 1,
                          ),
                      itemBuilder: (context, index) {
                        if (index < images.length) {
                          final img = images[index];
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child:
                                kIsWeb
                                    ? Image.network(img.path, fit: BoxFit.cover)
                                    : Image.file(
                                      File(img.path),
                                      fit: BoxFit.cover,
                                    ),
                          );
                        } else {
                          return GestureDetector(
                            onTap: pickImages,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.add,
                                  color: AppTheme.rosePink,
                                ),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ],
              ),
            ),
          ),
          body: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                color: const Color(0xFFF6F6F6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'ปฏิทิน',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        final now = DateTime.now();
                        ref.read(selectedDayProvider.notifier).state = now;
                        ref.read(focusedDayProvider.notifier).state = now;
                        ref.read(selectedMoodProvider.notifier).state = null;
                        ref.read(imageListProvider.notifier).state = [];
                        noteController.clear();
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppTheme.rosePink,
                        side: const BorderSide(color: AppTheme.rosePink),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                      ),
                      child: const Text('วันนี้'),
                    ),
                  ],
                ),
              ),
              TableCalendar(
                locale: 'th_TH',
                firstDay: DateTime.utc(2020, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                focusedDay: focusedDay,
                selectedDayPredicate: (day) => isSameDay(selectedDay, day),
                onDaySelected: (selected, focused) {
                  ref.read(selectedDayProvider.notifier).state = selected;
                  ref.read(focusedDayProvider.notifier).state = focused;
                  ref.read(selectedMoodProvider.notifier).state = null;
                  ref.read(imageListProvider.notifier).state = [];
                  noteController.clear();
                },
                headerStyle: const HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                ),
                calendarStyle: const CalendarStyle(
                  weekendTextStyle: TextStyle(color: Colors.black87),
                  todayDecoration: BoxDecoration(
                    color: AppTheme.rosePink,
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: Colors.pinkAccent,
                    shape: BoxShape.circle,
                  ),
                ),
                calendarBuilders: CalendarBuilders(
                  markerBuilder: (context, date, events) {
                    final moodIndex =
                        moodData[DateTime.utc(date.year, date.month, date.day)];
                    if (moodIndex != null) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: Image.asset(moodImages[moodIndex], height: 22),
                        ),
                      );
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          selectedDay != null
                              ? '${selectedDay.day} ${DateFormat.EEEE('th_TH').format(selectedDay)}'
                              : '${focusedDay.day} ${DateFormat.EEEE('th_TH').format(focusedDay)}',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.rosePink,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
