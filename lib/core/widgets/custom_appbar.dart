import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  final double progress;
  final int level;

  const CustomAppbar({super.key, required this.progress, required this.level});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: SizedBox(
          width: 250,
          height: 40,
          child: Stack(
            children: [
              // แถบเทา (background)
              Positioned.fill(
                left: 35,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                ),
              ),

              // แถบชมพู (progress)
              Positioned(
                left: 35,
                top: 5,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final barWidth = 250 * progress.clamp(0.0, 1.0) - 35;
                    return Container(
                      width: barWidth,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.pinkAccent.shade100,
                        borderRadius: BorderRadius.circular(40),
                      ),
                    );
                  },
                ),
              ),

              // เมฆ + ตัวเลข
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: 60,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.shade400, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '$level',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.pink,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
