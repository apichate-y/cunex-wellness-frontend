import 'package:cunex_wellness/core/widgets/optimized_image.dart';
import 'package:flutter/material.dart';

class NavItem extends StatelessWidget {
  final int index;
  final int selectedIndex;
  final String assetPath;
  final String activeAssetPath;
  final VoidCallback onTap;

  const NavItem({
    super.key,
    required this.index,
    required this.selectedIndex,
    required this.assetPath,
    required this.activeAssetPath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final bool isSelected = index == selectedIndex;

    final double selectedHeight = screenHeight * 0.05;
    final double selectedWidth = screenHeight * 0.09;
    final double iconSize = screenHeight * 0.025;

    return GestureDetector(
      onTap: onTap,
      child:
          isSelected
              ? Container(
                height: selectedHeight,
                width: selectedWidth,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: Image.asset(
                    activeAssetPath,
                    height: iconSize * 2,
                    width: iconSize * 2,
                  ),
                ),
              )
              : Image.asset(
                assetPath,
                height: iconSize,
                width: iconSize,
                color: Colors.white,
              ),
    );
  }
}
