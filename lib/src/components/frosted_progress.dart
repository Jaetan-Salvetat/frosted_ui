import 'package:flutter/material.dart';

class FrostedCircularProgressIndicator extends StatelessWidget {
  final double? value;
  final Color? color;
  final Color? backgroundColor;
  final double strokeWidth;
  final double size;

  const FrostedCircularProgressIndicator({
    super.key,
    this.value,
    this.color,
    this.backgroundColor,
    this.strokeWidth = 4.0,
    this.size = 40.0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    final primaryColor = color ?? colorScheme.primary;
    final trackColor =
        backgroundColor ??
        colorScheme.onSurface.withValues(alpha: isDark ? 0.1 : 0.05);

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        children: [
          // Track (Background) - Only show if determinate
          if (value != null)
            SizedBox.expand(
              child: CircularProgressIndicator(
                value: 1.0,
                color: trackColor,
                strokeWidth: strokeWidth,
              ),
            ),
          // Main indicator
          SizedBox.expand(
            child: CircularProgressIndicator(
              value: value,
              color: primaryColor,
              strokeWidth: strokeWidth,
              strokeCap: StrokeCap.round,
            ),
          ),
        ],
      ),
    );
  }
}

class FrostedLinearProgressIndicator extends StatelessWidget {
  final double? value;
  final Color? color;
  final Color? backgroundColor;
  final double minHeight;

  const FrostedLinearProgressIndicator({
    super.key,
    this.value,
    this.color,
    this.backgroundColor,
    this.minHeight = 6.0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    final primaryColor = color ?? colorScheme.primary;
    final trackColor =
        backgroundColor ??
        colorScheme.onSurface.withValues(alpha: isDark ? 0.1 : 0.05);

    return Container(
      height: minHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(minHeight / 2),
        color: trackColor,
        border: Border.all(
          color: colorScheme.onSurface.withValues(alpha: 0.1),
          width: 0.5,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(minHeight / 2),
        child: value == null
            ? LinearProgressIndicator(
                backgroundColor: Colors.transparent,
                color: primaryColor,
                minHeight: minHeight,
              )
            : LayoutBuilder(
                builder: (context, constraints) {
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: constraints.maxWidth * value!,
                      height: minHeight,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(minHeight / 2),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
