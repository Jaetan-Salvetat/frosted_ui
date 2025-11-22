import 'package:flutter/material.dart';

class FrostedSlider extends StatelessWidget {
  final double value;
  final ValueChanged<double>? onChanged;
  final double min;
  final double max;
  final int? divisions;
  final String? label;
  final Color? activeColor;
  final Color? inactiveColor;

  const FrostedSlider({
    super.key,
    required this.value,
    required this.onChanged,
    this.min = 0.0,
    this.max = 1.0,
    this.divisions,
    this.label,
    this.activeColor,
    this.inactiveColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    final primaryColor = activeColor ?? colorScheme.primary;
    final trackInactive =
        inactiveColor ??
        (isDark
            ? Colors.white.withOpacity(0.1)
            : Colors.black.withOpacity(0.05));

    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        trackHeight: 6,
        activeTrackColor: primaryColor,
        inactiveTrackColor: trackInactive,
        thumbColor: primaryColor,
        overlayColor: primaryColor.withOpacity(0.1),
        valueIndicatorColor: primaryColor,
        valueIndicatorTextStyle: TextStyle(color: colorScheme.onPrimary),
        thumbShape: _FrostedThumbShape(
          enabledThumbRadius: 10,
          elevation: 4,
          pressedElevation: 8,
        ),
        trackShape: _FrostedTrackShape(),
        overlayShape: const RoundSliderOverlayShape(overlayRadius: 24),
      ),
      child: Slider(
        value: value,
        onChanged: onChanged,
        min: min,
        max: max,
        divisions: divisions,
        label: label,
      ),
    );
  }
}

class _FrostedThumbShape extends SliderComponentShape {
  final double enabledThumbRadius;
  final double elevation;
  final double pressedElevation;

  const _FrostedThumbShape({
    this.enabledThumbRadius = 10.0,
    this.elevation = 1.0,
    this.pressedElevation = 6.0,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(enabledThumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;
    final ColorTween colorTween = ColorTween(
      begin: sliderTheme.disabledThumbColor,
      end: sliderTheme.thumbColor,
    );
    final Color color = colorTween.evaluate(enableAnimation)!;
    final double radius = enabledThumbRadius;

    final Tween<double> elevationTween = Tween<double>(
      begin: elevation,
      end: pressedElevation,
    );
    final double evaluatedElevation = elevationTween.evaluate(
      activationAnimation,
    );

    // Ombre
    final Path path = Path()
      ..addOval(Rect.fromCircle(center: center, radius: radius));
    canvas.drawShadow(path, Colors.black, evaluatedElevation, true);

    // Cercle principal
    canvas.drawCircle(center, radius, Paint()..color = color);

    // Glow effect
    if (activationAnimation.value > 0) {
      canvas.drawCircle(
        center,
        radius + (activationAnimation.value * 4),
        Paint()
          ..color = color.withOpacity(0.3 * activationAnimation.value)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4),
      );
    }

    // Centre blanc/clair pour effet de relief
    canvas.drawCircle(
      center,
      radius * 0.4,
      Paint()..color = Colors.white.withOpacity(0.3),
    );
  }
}

class _FrostedTrackShape extends RoundedRectSliderTrackShape {
  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required TextDirection textDirection,
    required Offset thumbCenter,
    Offset? secondaryOffset,
    bool isDiscrete = false,
    bool isEnabled = false,
    double additionalActiveTrackHeight = 2,
  }) {
    super.paint(
      context,
      offset,
      parentBox: parentBox,
      sliderTheme: sliderTheme,
      enableAnimation: enableAnimation,
      textDirection: textDirection,
      thumbCenter: thumbCenter,
      secondaryOffset: secondaryOffset,
      isDiscrete: isDiscrete,
      isEnabled: isEnabled,
      additionalActiveTrackHeight: 0,
    );
  }
}
