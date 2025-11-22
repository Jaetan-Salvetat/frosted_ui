import 'package:flutter/material.dart';
import 'dart:ui';

class FrostedTooltip extends StatelessWidget {
  final String message;
  final Widget child;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? verticalOffset;
  final bool preferBelow;
  final bool? excludeFromSemantics;
  final Duration? waitDuration;
  final Duration? showDuration;
  final TextStyle? textStyle;
  final TextAlign? textAlign;
  final Decoration? decoration;

  const FrostedTooltip({
    super.key,
    required this.message,
    required this.child,
    this.height,
    this.padding,
    this.margin,
    this.verticalOffset,
    this.preferBelow = true,
    this.excludeFromSemantics,
    this.waitDuration,
    this.showDuration,
    this.textStyle,
    this.textAlign,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final bgColor = isDark
        ? const Color(0xFF303030).withOpacity(0.9)
        : const Color(0xFFFAFAFA).withOpacity(0.9);
    final txtColor = isDark ? Colors.white : Colors.black87;

    return Tooltip(
      message: message,
      height: height,
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      margin: margin,
      verticalOffset: verticalOffset,
      preferBelow: preferBelow,
      excludeFromSemantics: excludeFromSemantics,
      waitDuration: waitDuration,
      showDuration: showDuration,
      textStyle:
          textStyle ??
          TextStyle(color: txtColor, fontSize: 12, fontWeight: FontWeight.w500),
      textAlign: textAlign,
      decoration:
          decoration ??
          BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isDark
                  ? Colors.white.withOpacity(0.1)
                  : Colors.black.withOpacity(0.05),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
      child: child,
    );
  }
}
