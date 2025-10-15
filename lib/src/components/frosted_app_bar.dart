import 'dart:ui';
import 'package:flutter/material.dart';

class FrostedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool showBackButton;
  final double height;
  final double blurStrength;

  const FrostedAppBar({
    super.key,
    required this.title,
    this.actions,
    this.height = 56,
    this.blurStrength = 7,
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurStrength, sigmaY: blurStrength),
        child: AppBar(
          centerTitle: true,
          title: Text(title),
          actions: actions,
          backgroundColor: Theme.of(
            context,
          ).colorScheme.surface.withValues(alpha: 0.7),
          surfaceTintColor: Colors.transparent,
          leading: showBackButton
              ? BackButton(onPressed: () => Navigator.pop(context))
              : null,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
