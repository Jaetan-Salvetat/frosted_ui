import 'package:flutter/material.dart';

class FrostedSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final Color? activeColor;
  final Color? activeTrackColor;
  final Color? inactiveThumbColor;
  final Color? inactiveTrackColor;

  const FrostedSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.activeColor,
    this.activeTrackColor,
    this.inactiveThumbColor,
    this.inactiveTrackColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    final primaryColor = activeColor ?? colorScheme.primary;
    final trackActive = activeTrackColor ?? primaryColor.withValues(alpha: 0.5);

    final thumbInactive =
        inactiveThumbColor ??
        (isDark ? colorScheme.onSurfaceVariant : colorScheme.surface);
    final trackInactive =
        inactiveTrackColor ??
        colorScheme.onSurface.withValues(alpha: isDark ? 0.1 : 0.1);

    return GestureDetector(
      onTap: onChanged != null ? () => onChanged!(!value) : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 52,
        height: 32,
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: value ? trackActive : trackInactive,
          border: Border.all(
            color: value
                ? primaryColor.withValues(alpha: 0.5)
                : colorScheme.onSurface.withValues(alpha: isDark ? 0.1 : 0.05),
            width: 1,
          ),
        ),
        child: Stack(
          children: [
            AnimatedAlign(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              alignment: value ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                width: 26,
                height: 26,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: value ? primaryColor : thumbInactive,
                  boxShadow: [
                    BoxShadow(
                      color: colorScheme.shadow.withValues(alpha: 0.2),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                    if (value)
                      BoxShadow(
                        color: primaryColor.withValues(alpha: 0.4),
                        blurRadius: 8,
                        spreadRadius: 1,
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
