import 'package:cunex_wellness/config/color.dart';
import 'package:cunex_wellness/config/sizebox.dart';
import 'package:cunex_wellness/core/widgets/nav_item.dart';
import 'package:flutter/material.dart';

class CustomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const CustomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: screenWidth,
      height: 100,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Container(
                  width: screenWidth,
                  height: 10,
                  color: AppTheme.rosePink,
                ),
                SizeBox.height5,
                Container(
                  height: 75,
                  color: AppTheme.rosePink,
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      NavItem(
                        index: 0,
                        selectedIndex: selectedIndex,
                        assetPath:
                            'lib/assets/images/icons/5 main buttons/calendar2.png',
                        activeAssetPath:
                            'lib/assets/images/icons/5 main buttons/calendar.png',
                        onTap: () => onTap(0),
                      ),
                      NavItem(
                        index: 1,
                        selectedIndex: selectedIndex,
                        assetPath:
                            'lib/assets/images/icons/5 main buttons/home2.png',
                        activeAssetPath:
                            'lib/assets/images/icons/5 main buttons/home.png',
                        onTap: () => onTap(1),
                      ),
                      NavItem(
                        index: 2,
                        selectedIndex: selectedIndex,
                        assetPath:
                            'lib/assets/images/icons/5 main buttons/profile2.png',
                        activeAssetPath:
                            'lib/assets/images/icons/5 main buttons/profile.png',
                        onTap: () => onTap(2),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
