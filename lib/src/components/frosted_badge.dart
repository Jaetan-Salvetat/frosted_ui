import 'package:flutter/material.dart';

class FrostedBadge extends StatelessWidget {
  final Widget child;
  final String? label;
  final int? count;
  final bool showZero;
  final Color? color;
  final Color? textColor;
  final double? size;
  final Offset offset;

  const FrostedBadge({
    super.key,
    required this.child,
    this.label,
    this.count,
    this.showZero = false,
    this.color,
    this.textColor,
    this.size,
    this.offset = const Offset(6, -6),
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final badgeColor = color ?? colorScheme.error;
    final onBadgeColor = textColor ?? colorScheme.onError;

    String? text;
    if (label != null) {
      text = label;
    } else if (count != null) {
      if (count == 0 && !showZero) {
        text = null;
      } else if (count! > 99) {
        text = '99+';
      } else {
        text = count.toString();
      }
    }

    if (text == null && label == null && count == null) {
      // Small dot
      return Stack(
        clipBehavior: Clip.none,
        children: [
          child,
          Positioned(
            top: offset.dy + 4,
            right: offset.dx + 4,
            child: Container(
              width: size ?? 8,
              height: size ?? 8,
              decoration: BoxDecoration(
                color: badgeColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: badgeColor.withOpacity(0.4),
                    blurRadius: 4,
                    spreadRadius: 1,
                  ),
                ],
                border: Border.all(
                  color: theme.scaffoldBackgroundColor.withOpacity(0.5),
                  width: 1,
                ),
              ),
            ),
          ),
        ],
      );
    }

    if (text == null) return child;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        child,
        Positioned(
          top: offset.dy,
          right: offset.dx,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            constraints: BoxConstraints(
              minWidth: size ?? 18,
              minHeight: size ?? 18,
            ),
            decoration: BoxDecoration(
              color: badgeColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: badgeColor.withOpacity(0.4),
                  blurRadius: 6,
                  spreadRadius: 1,
                ),
              ],
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  color: onBadgeColor,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
