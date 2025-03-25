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
    final bool isSelected = index == selectedIndex;

    return GestureDetector(
      onTap: onTap,
      child: isSelected
          ? Container(
              height: 45,
              width: 80,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  )
                ],
              ),
              child: Center(
                child: Image.asset(
                  activeAssetPath,
                  height: 50,
                  width: 50,
                ),
              ),
            )
          : Image.asset(
              assetPath,
              height: 28,
              width: 28,
              color: Colors.white,
            ),
    );
  }
}
