import 'dart:ui';
import 'package:flutter/material.dart';

/// A Material 3 Navigation Drawer with a frosted glass effect.
class FrostedNavigationDrawer extends StatelessWidget {
  /// The list of widgets to display in the drawer.
  /// Usually contains [NavigationDrawerDestination]s and [Padding]s or [Divider]s.
  final List<Widget> children;

  /// The index of the currently selected [NavigationDrawerDestination].
  final int? selectedIndex;

  /// Called when one of the [NavigationDrawerDestination]s is selected.
  final void Function(int)? onDestinationSelected;

  /// The background color of the drawer.
  /// If null, uses the theme's surface container with opacity.
  final Color? backgroundColor;

  /// The shape of the drawer.
  final ShapeBorder? shape;

  /// The elevation of the drawer.
  final double? elevation;

  const FrostedNavigationDrawer({
    super.key,
    required this.children,
    this.selectedIndex,
    this.onDestinationSelected,
    this.backgroundColor,
    this.shape,
    this.elevation,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    // Base color with transparency for frosted effect
    final baseColor =
        backgroundColor ??
        (isDark
            ? colorScheme.surfaceContainerLow
            : colorScheme.surfaceContainer);

    final frostedColor = baseColor.withValues(alpha: 0.7);

    // Border color
    final borderColor = colorScheme.onSurface.withValues(alpha: 0.1);

    return ClipRRect(
      borderRadius: const BorderRadius.horizontal(
        right: Radius.circular(16),
      ), // Match default shape
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            border: Border(right: BorderSide(color: borderColor, width: 0.5)),
          ),
          child: NavigationDrawer(
            children: children,
            selectedIndex: selectedIndex,
            onDestinationSelected: onDestinationSelected,
            backgroundColor: frostedColor,
            elevation:
                0, // We rely on the scaffold's drawer shadow or add our own if needed
            shadowColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
          ),
        ),
      ),
    );
  }
}
