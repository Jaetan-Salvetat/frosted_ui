import 'dart:ui';
import 'package:flutter/material.dart';

/// Affiche un dialogue avec effet de givrage et fond dépoli
class FrostedDialog extends StatelessWidget {
  final Widget content;
  final Widget? title;
  final List<Widget>? actions;
  final double blurStrength;
  final Color? backgroundColor;
  final EdgeInsetsGeometry contentPadding;
  final EdgeInsetsGeometry titlePadding;
  final EdgeInsetsGeometry actionsPadding;
  final double borderRadius;

  const FrostedDialog({
    super.key,
    required this.content,
    this.title,
    this.actions,
    this.blurStrength = 15.0,
    this.backgroundColor,
    this.contentPadding = const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 24.0),
    this.titlePadding = const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 0.0),
    this.actionsPadding = const EdgeInsets.symmetric(
      horizontal: 16.0,
      vertical: 8.0,
    ),
    this.borderRadius = 12.0,
  });

  @override
  Widget build(BuildContext context) {
    final Color dialogColor =
        backgroundColor?.withValues(alpha: 0.7) ??
        Theme.of(context).colorScheme.surface.withValues(alpha: 0.7);

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurStrength, sigmaY: blurStrength),
        child: Container(
          decoration: BoxDecoration(
            color: dialogColor,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.1),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (title != null)
                Padding(
                  padding: titlePadding,
                  child: DefaultTextStyle(
                    style: Theme.of(context).textTheme.titleLarge!,
                    child: title!,
                  ),
                ),
              Padding(
                padding: contentPadding,
                child: DefaultTextStyle(
                  style: Theme.of(context).textTheme.bodyMedium!,
                  child: content,
                ),
              ),
              if (actions != null)
                Padding(
                  padding: actionsPadding,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: actions!,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  static Future<T?> show<T>({
    required BuildContext context,
    required Widget content,
    Widget? title,
    List<Widget>? actions,
    double blurStrength = 7.0,
    Color? backgroundColor,
    bool barrierDismissible = true,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierColor: Colors.black.withValues(alpha: 0.5),
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurStrength, sigmaY: blurStrength),
        child: Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 24.0,
          ),
          child: FrostedDialog(
            content: content,
            title: title,
            actions: actions,
            blurStrength: blurStrength,
            backgroundColor: backgroundColor,
          ),
        ),
      ),
    );
  }
}
