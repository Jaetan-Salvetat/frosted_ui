import 'dart:ui';
import 'package:flutter/material.dart';

/// SliverAppBar avec effet de givrage et dépoli pour créer une interface moderne
///
/// Basé sur le SliverAppBar.large de Flutter qui montre un titre en grand format
/// qui se réduit lors du défilement.
class FrostedSliverAppBar extends StatelessWidget {
  final String? title;
  final Widget? titleWidget;
  final double blurStrength;
  final double expandedHeight;
  final bool pinned;
  final bool floating;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final bool showBackButton;
  final Widget? leading;

  const FrostedSliverAppBar({
    super.key,
    this.title,
    this.titleWidget,
    this.blurStrength = 5.0,
    this.expandedHeight = 150.0,
    this.pinned = true,
    this.floating = true,
    this.actions,
    this.backgroundColor,
    this.showBackButton = true,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    final Color appBarColor =
        backgroundColor?.withValues(alpha: 0.7) ??
        Theme.of(context).colorScheme.surface.withValues(alpha: 0.7);

    final bool hasLeading = leading != null || showBackButton;

    return SliverAppBar(
      expandedHeight: expandedHeight,
      floating: floating,
      pinned: pinned,
      snap: false,
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      automaticallyImplyLeading: showBackButton,
      leading:
          leading ??
          (showBackButton
              ? BackButton(onPressed: () => Navigator.pop(context))
              : null),
      actions: actions,
      flexibleSpace: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blurStrength, sigmaY: blurStrength),
          child: FlexibleSpaceBar(
            title: _DynamicTitle(
              hasLeading: hasLeading,
              child: title != null ? Text(title!) : titleWidget!,
            ),
            centerTitle: false,
            titlePadding: const EdgeInsets.only(bottom: 12),
            expandedTitleScale: 1.5,
            collapseMode: CollapseMode.pin,
            background: Container(color: appBarColor),
          ),
        ),
      ),
    );
  }
}

class _DynamicTitle extends StatelessWidget {
  final Widget child;
  final bool hasLeading;

  const _DynamicTitle({required this.child, required this.hasLeading});

  @override
  Widget build(BuildContext context) {
    final settings = context
        .dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>();

    // If no settings or no leading widget, just return content with default 16px padding
    // Wait, if no leading, we still want 16px expanded.
    // If hasLeading is false, we want 16px always.
    // Collapsed (Scale 1.0) -> 16. Expanded (Scale 1.5) -> 16/1.5 = 10.67.
    // So we should interpolate always, but with different start values?
    // User said: "padding ... in extended mode must remain 16".
    // If no leading, collapsed can be 16 too.

    if (settings == null)
      return Padding(padding: const EdgeInsets.only(left: 16), child: child);

    final double delta = settings.maxExtent - settings.minExtent;
    final double t = delta == 0
        ? 1.0
        : (settings.currentExtent - settings.minExtent) / delta;
    final double tClamped = t.clamp(0.0, 1.0);

    // Target Visual Padding:
    // Expanded (t=1): 16px.
    // Collapsed (t=0):
    //   If hasLeading: 60px.
    //   If !hasLeading: 16px.

    final double targetCollapsed = hasLeading ? 50.0 : 16.0;
    final double targetExpanded = 16.0;

    // Adjusted for Scale (Expanded scale is 1.5)
    // At t=0 (Collapsed), scale is 1.0. Internal padding = targetCollapsed.
    // At t=1 (Expanded), scale is 1.5. Internal padding = targetExpanded / 1.5.

    final double startPadding = targetCollapsed;
    final double endPadding = targetExpanded / 1.5;

    final double padding = lerpDouble(startPadding, endPadding, tClamped)!;

    return Padding(
      padding: EdgeInsets.only(left: padding),
      child: child,
    );
  }
}
