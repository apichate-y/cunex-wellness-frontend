import 'package:cunex_wellness/config/color.dart';
import 'package:cunex_wellness/core/controllers/background_controller.dart';
import 'package:cunex_wellness/core/enums/day_period.dart' as dp;
import 'package:cunex_wellness/core/widgets/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PersonalInfoScreen extends StatelessWidget {
  const PersonalInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final backgroundController = Get.find<BackgroundController>();
    final period = dp.getDayPeriod();
    final textColor =
        (period == dp.DayPeriod.earlyMorning || period == dp.DayPeriod.night)
            ? Colors.white
            : Colors.black;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Obx(
            () => CachedImage(
              imagePath: backgroundController.backgroundImage.value,
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(24, 16, 24, 80),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 8),
                            Center(
                              child: Text(
                                'ประวัติส่วนตัว',
                                style: TextStyle(
                                  color: textColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Center(
                              child: CircleAvatar(
                                radius: 50,
                                backgroundImage: AssetImage(
                                  'lib/assets/images/element/j.png',
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    buildField(
                                      context,
                                      label: 'ชื่อ',
                                      textColor: textColor,
                                      widthRatio: 0.42,
                                    ),
                                    buildField(
                                      context,
                                      label: 'นามสกุล',
                                      textColor: textColor,
                                      widthRatio: 0.42,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    buildField(
                                      context,
                                      label: 'Name',
                                      textColor: textColor,
                                      widthRatio: 0.42,
                                    ),
                                    buildField(
                                      context,
                                      label: 'Surname',
                                      textColor: textColor,
                                      widthRatio: 0.42,
                                    ),
                                  ],
                                ),
                                buildField(
                                  context,
                                  label: 'เลขบัตรประจำตัวประชาชน',
                                  textColor: textColor,
                                  fullWidth: true,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    buildField(
                                      context,
                                      label: 'วัน',
                                      textColor: textColor,
                                      widthRatio: 0.28,
                                    ),
                                    buildField(
                                      context,
                                      label: 'เดือน',
                                      textColor: textColor,
                                      widthRatio: 0.28,
                                    ),
                                    buildField(
                                      context,
                                      label: 'ปี',
                                      textColor: textColor,
                                      widthRatio: 0.28,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    buildField(
                                      context,
                                      label: 'อายุ',
                                      textColor: textColor,
                                      widthRatio: 0.28,
                                    ),
                                    buildField(
                                      context,
                                      label: 'น้ำหนัก',
                                      textColor: textColor,
                                      widthRatio: 0.28,
                                    ),
                                    buildField(
                                      context,
                                      label: 'ส่วนสูง',
                                      textColor: textColor,
                                      widthRatio: 0.28,
                                    ),
                                  ],
                                ),
                                buildField(
                                  context,
                                  label: 'ที่อยู่',
                                  textColor: textColor,
                                  fullWidth: true,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          right: 12,
                                        ),
                                        child: buildField(
                                          context,
                                          label: 'เบอร์โทรศัพท์',
                                          textColor: textColor,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          left: 12,
                                        ),
                                        child: buildField(
                                          context,
                                          label: 'เบอร์โทรศัพท์ ( ฉุกเฉิน )',
                                          textColor: textColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                buildField(
                                  context,
                                  label: 'โรคประจำตัว',
                                  textColor: textColor,
                                  fullWidth: true,
                                ),

                                buildField(
                                  context,
                                  label: 'ประวัติการแพ้ยา',
                                  textColor: textColor,
                                  fullWidth: true,
                                ),
                                const SizedBox(height: 20),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildField(
    BuildContext context, {
    required String label,
    required Color textColor,
    double? widthRatio,
    bool fullWidth = false,
  }) {
    double screenWidth = MediaQuery.of(context).size.width;
    double width =
        fullWidth
            ? screenWidth - 48
            : widthRatio != null
            ? screenWidth * widthRatio
            : (screenWidth - 64) / 2;

    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(color: textColor, fontSize: 16)),
          const SizedBox(height: 5),
          Container(
            height: 45,
            decoration: BoxDecoration(
              color: AppTheme.greyUltraLight,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.black12),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
