import 'dart:io';
import 'package:cunex_wellness/config/color.dart';
import 'package:cunex_wellness/core/widgets/cached_image.dart';
import 'package:cunex_wellness/features/calendar/providers/calendar_controller.dart';
import 'package:cunex_wellness/routes/app_pages.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final TextEditingController noteController = TextEditingController();
  final panelController = PanelController();
  late CalendarController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.find<CalendarController>();
  }

  List<Widget> _buildMoodSelector(double iconSize) {
    return List.generate(6, (index) {
      return GestureDetector(
        onTap: () {
          controller.selectedMood.value = index;
        },
        child: SizedBox(
          width: iconSize,
          height: iconSize,
          child: FittedBox(
            fit: BoxFit.contain,
            child: CachedImage(imagePath: controller.moodImages[index]),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
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
            controller.panelPosition.value = position;
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
                  Obx(() {
                    if (controller.selectedMood.value == null) {
                      return GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 3,
                        crossAxisSpacing: screenWidth * 0.04,
                        mainAxisSpacing: screenWidth * 0.04,
                        children: _buildMoodSelector(iconSize),
                      );
                    } else {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(() {
                            if (controller.panelPosition.value > 0.95) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10.0,
                                ),
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
                                            Get.toNamed(Routes.QR_SCAN);
                                          }
                                        },
                                        value: 'everyone',
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              return const SizedBox.shrink();
                            }
                          }),
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
                          Obx(() {
                            final images = controller.imageList;
                            return GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount:
                                  images.length < 9 ? images.length + 1 : 9,
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
                                            ? Image.network(
                                              img.path,
                                              fit: BoxFit.cover,
                                            )
                                            : Image.file(
                                              File(img.path),
                                              fit: BoxFit.cover,
                                            ),
                                  );
                                } else {
                                  return GestureDetector(
                                    onTap: controller.pickImages,
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
                            );
                          }),
                        ],
                      );
                    }
                  }),
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
                      onPressed: controller.resetToToday,
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
              Obx(
                () => TableCalendar(
                  locale: 'th_TH',
                  firstDay: DateTime.utc(2020, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  focusedDay: controller.focusedDay.value,
                  selectedDayPredicate:
                      (day) => isSameDay(controller.selectedDay.value, day),
                  onDaySelected: controller.onDaySelected,
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
                          controller.moodData[DateTime.utc(
                            date.year,
                            date.month,
                            date.day,
                          )];
                      if (moodIndex != null) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 30.0),
                            child: CachedImage(
                              imagePath: controller.moodImages[moodIndex],
                              height: 22,
                            ),
                          ),
                        );
                      }
                      return null;
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Obx(() {
                          final selectedDay = controller.selectedDay.value;
                          final focusedDay = controller.focusedDay.value;
                          return Text(
                            selectedDay != null
                                ? '${selectedDay.day} ${DateFormat.EEEE('th_TH').format(selectedDay)}'
                                : '${focusedDay.day} ${DateFormat.EEEE('th_TH').format(focusedDay)}',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.rosePink,
                            ),
                          );
                        }),
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
