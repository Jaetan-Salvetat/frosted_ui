import 'package:flutter/material.dart';

class FrostedTabs extends StatelessWidget {
  final List<String> tabs;
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? indicatorColor;

  const FrostedTabs({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onTabSelected,
    this.activeColor,
    this.inactiveColor,
    this.indicatorColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    final primaryColor = activeColor ?? colorScheme.primary;
    final onSurfaceVariant = inactiveColor ?? colorScheme.onSurfaceVariant;
    final indicator =
        indicatorColor ??
        (isDark ? Colors.white.withOpacity(0.1) : Colors.white);

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.black.withOpacity(0.2)
            : Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          // Sliding Indicator
          Positioned.fill(
            child: AnimatedAlign(
              alignment: Alignment(
                tabs.length > 1
                    ? -1.0 + (selectedIndex / (tabs.length - 1)) * 2.0
                    : 0.0,
                0.0,
              ),
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              child: FractionallySizedBox(
                widthFactor: 1 / tabs.length,
                child: Container(
                  decoration: BoxDecoration(
                    color: indicator,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Tabs Content
          Row(
            children: List.generate(tabs.length, (index) {
              final isSelected = index == selectedIndex;
              return Expanded(
                child: GestureDetector(
                  onTap: () => onTabSelected(index),
                  child: Container(
                    color: Colors.transparent, // Hit test area
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      tabs[index],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: isSelected ? primaryColor : onSurfaceVariant,
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.normal,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
