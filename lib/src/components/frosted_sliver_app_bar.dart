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

  const FrostedSliverAppBar({
    super.key,
    this.title,
    this.titleWidget,
    this.blurStrength = 5.0,
    this.expandedHeight = 200.0,
    this.pinned = true,
    this.floating = true,
    this.actions,
    this.backgroundColor,
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    final Color appBarColor =
        backgroundColor?.withValues(alpha: 0.7) ??
        Theme.of(context).colorScheme.surface.withValues(alpha: 0.7);

    return SliverAppBar(
      expandedHeight: expandedHeight,
      floating: floating,
      pinned: pinned,
      snap: false,
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      automaticallyImplyLeading: showBackButton,
      leading: showBackButton
          ? BackButton(onPressed: () => Navigator.pop(context))
          : null,
      actions: actions,
      flexibleSpace: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blurStrength, sigmaY: blurStrength),
          child: FlexibleSpaceBar(
            title: title != null ? Text(title!) : titleWidget,
            centerTitle: false,
            titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
            expandedTitleScale: 1.5,
            collapseMode: CollapseMode.pin,
            background: Container(color: appBarColor),
          ),
        ),
      ),
    );
  }
}
