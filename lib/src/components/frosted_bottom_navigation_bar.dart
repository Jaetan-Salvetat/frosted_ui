import 'dart:ui';
import 'package:flutter/material.dart';

class FrostedBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<BottomNavigationBarItem> items;
  final double blurStrength;

  const FrostedBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
    this.blurStrength = 7,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurStrength, sigmaY: blurStrength),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: onTap,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: false,
          backgroundColor: Theme.of(
            context,
          ).colorScheme.surface.withValues(alpha: 0.7),
          elevation: 0,
          items: items,
        ),
      ),
    );
  }
}
