import 'dart:ui';
import 'package:flutter/material.dart';

/// A Material 3 Navigation Rail with a frosted glass effect.
class FrostedNavigationRail extends StatelessWidget {
  /// The list of destinations to display in the rail.
  final List<NavigationRailDestination> destinations;

  /// The index of the currently selected destination.
  final int selectedIndex;

  /// Called when one of the destinations is selected.
  final ValueChanged<int>? onDestinationSelected;

  /// The background color of the rail.
  /// If null, uses the theme's surface container with opacity.
  final Color? backgroundColor;

  /// Whether the rail is extended (shows labels next to icons).
  final bool extended;

  /// A widget to display at the top of the rail (e.g. a FAB).
  final Widget? leading;

  /// A widget to display at the bottom of the rail.
  final Widget? trailing;

  /// The minimum width of the rail when not extended.
  final double minWidth;

  /// The minimum width of the rail when extended.
  final double minExtendedWidth;

  /// The alignment of the destinations within the rail.
  final double? groupAlignment;

  const FrostedNavigationRail({
    super.key,
    required this.destinations,
    required this.selectedIndex,
    this.onDestinationSelected,
    this.backgroundColor,
    this.extended = false,
    this.leading,
    this.trailing,
    this.minWidth = 72.0,
    this.minExtendedWidth = 256.0,
    this.groupAlignment,
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

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            color: frostedColor,
            border: Border(right: BorderSide(color: borderColor, width: 0.5)),
          ),
          child: NavigationRail(
            destinations: destinations,
            selectedIndex: selectedIndex,
            onDestinationSelected: onDestinationSelected,
            backgroundColor: Colors.transparent,
            extended: extended,
            leading: leading,
            trailing: trailing,
            minWidth: minWidth,
            minExtendedWidth: minExtendedWidth,
            groupAlignment: groupAlignment,
            elevation: 0,
          ),
        ),
      ),
    );
  }
}
