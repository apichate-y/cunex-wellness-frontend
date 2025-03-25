import 'package:cunex_wellness/config/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

class CalendarScreen extends ConsumerWidget {
  const CalendarScreen({super.key});

  List<Widget> _buildMoodSelector(WidgetRef ref, DateTime? selectedDay) {
    return List.generate(6, (index) {
      return GestureDetector(
        onTap: () {
          if (selectedDay != null) {
            ref.read(moodDataProvider.notifier).setMood(selectedDay, index);
            ref.read(showNoteProvider.notifier).state = true;
          }
        },
        child: Image.asset(moodImages[index], height: 65),
      );
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final moodData = ref.watch(moodDataProvider);
    final selectedDay = ref.watch(selectedDayProvider);
    final focusedDay = ref.watch(focusedDayProvider);
    final showNote = ref.watch(showNoteProvider);
    final noteText = ref.watch(noteTextProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SlidingUpPanel(
          color: AppTheme.greyUltraLight,
          minHeight: showNote ? 380 : 160,
          maxHeight: MediaQuery.of(context).size.height * 0.75,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
          panel: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 3,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    children: _buildMoodSelector(ref, selectedDay),
                  ),
                  if (showNote) ...[
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'วันนี้เป็นยังไงบ้าง เล่าให้ฟังหน่อยสิ',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppTheme.rosePink,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
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
                      onChanged:
                          (val) =>
                              ref.read(noteTextProvider.notifier).state = val,
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
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppTheme.rosePink,
                        side: const BorderSide(color: AppTheme.rosePink),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: EdgeInsets.zero,
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
                child: Row(
                  children: [
                    Text(
                      selectedDay != null
                          ? '${selectedDay.day} ${DateFormat.EEEE('th_TH').format(selectedDay)}'
                          : '${focusedDay.day} ${DateFormat.EEEE('th_TH').format(focusedDay)}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.rosePink,
                      ),
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
