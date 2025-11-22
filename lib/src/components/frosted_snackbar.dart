import 'package:flutter/material.dart';
import 'dart:ui';

class FrostedSnackbar extends StatelessWidget {
  final String message;
  final Widget? icon;
  final SnackBarAction? action;
  final Color? backgroundColor;
  final Color? textColor;

  const FrostedSnackbar({
    super.key,
    required this.message,
    this.icon,
    this.action,
    this.backgroundColor,
    this.textColor,
  });

  // Méthode statique pour afficher la snackbar facilement
  static void show(
    BuildContext context, {
    required String message,
    Widget? icon,
    SnackBarAction? action,
    Duration duration = const Duration(seconds: 4),
    Color? backgroundColor,
    Color? textColor,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: FrostedSnackbar(
          message: message,
          icon: icon,
          action: action,
          backgroundColor: backgroundColor,
          textColor: textColor,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        duration: duration,
        padding: EdgeInsets.zero,
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    final bgColor =
        backgroundColor ??
        (isDark ? colorScheme.surfaceContainerHighest : colorScheme.surface);
    final txtColor =
        textColor ?? (isDark ? colorScheme.onSurface : colorScheme.onSurface);

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: bgColor.withValues(alpha: 0.8),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: colorScheme.onSurface.withValues(alpha: 0.1),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: colorScheme.shadow.withValues(alpha: 0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              if (icon != null) ...[icon!, const SizedBox(width: 12)],
              Expanded(
                child: Text(
                  message,
                  style: TextStyle(
                    color: txtColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              if (action != null) ...[
                const SizedBox(width: 8),
                TextButton(
                  onPressed: action!.onPressed,
                  style: TextButton.styleFrom(
                    foregroundColor:
                        action!.textColor ?? theme.colorScheme.primary,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    minimumSize: const Size(60, 36),
                  ),
                  child: Text(action!.label),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
