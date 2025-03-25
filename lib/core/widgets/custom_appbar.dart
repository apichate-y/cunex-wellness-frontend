import 'package:cunex_wellness/config/color.dart';
import 'package:cunex_wellness/config/sizebox.dart' show SizeBox;
import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    return Column(
      children: [
        Container(width: screenWidth, height: 90, color: AppTheme.rosePink),
        SizeBox.height5,
        Container(width: screenWidth, height: 10, color: AppTheme.rosePink),
      ],
    );
  }
}
