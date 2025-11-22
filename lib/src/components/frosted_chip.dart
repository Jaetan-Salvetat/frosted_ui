import 'package:flutter/material.dart';
import 'package:frosted_ui/frosted_ui.dart';

class FrostedChip extends StatelessWidget {
  final Widget label;
  final Widget? avatar;
  final VoidCallback? onDeleted;
  final VoidCallback? onPressed;
  final bool selected;
  final Color? selectedColor;
  final Color? backgroundColor;
  final Color? labelColor;

  const FrostedChip({
    super.key,
    required this.label,
    this.avatar,
    this.onDeleted,
    this.onPressed,
    this.selected = false,
    this.selectedColor,
    this.backgroundColor,
    this.labelColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    final primaryColor = selectedColor ?? colorScheme.primary;
    final baseColor =
        backgroundColor ??
        (isDark
            ? Colors.white.withValues(alpha: 0.05)
            : Colors.black.withValues(alpha: 0.05));

    final effectiveBackgroundColor = selected
        ? primaryColor.withValues(alpha: 0.2)
        : baseColor;
    final effectiveBorderColor = selected
        ? primaryColor
        : isDark
        ? Colors.white.withValues(alpha: 0.1)
        : Colors.black.withValues(alpha: 0.1);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(FrostedButtonStyle.buttonRadius),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.fromLTRB(
            avatar != null ? 4 : 12,
            8,
            onDeleted != null ? 8 : 12,
            8,
          ),
          decoration: BoxDecoration(
            color: effectiveBackgroundColor,
            borderRadius: BorderRadius.circular(
              FrostedButtonStyle.buttonRadius,
            ),
            border: Border.all(color: effectiveBorderColor, width: 1),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (avatar != null) ...[avatar!, const SizedBox(width: 8)],
              DefaultTextStyle(
                style: TextStyle(
                  color: selected
                      ? primaryColor
                      : labelColor ?? theme.textTheme.bodyMedium?.color,
                  fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                  fontSize: 14,
                ),
                child: label,
              ),
              if (onDeleted != null) ...[
                const SizedBox(width: 8),
                InkWell(
                  onTap: onDeleted,
                  borderRadius: BorderRadius.circular(
                    FrostedButtonStyle.buttonRadius,
                  ),
                  child: Icon(
                    Icons.close,
                    size: 18,
                    color: selected
                        ? primaryColor
                        : theme.iconTheme.color?.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
