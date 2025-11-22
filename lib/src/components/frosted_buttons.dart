import 'package:flutter/material.dart';

/// Style de bordure arrondie pour les boutons
class FrostedButtonStyle {
  /// Rayon de bordure fixe pour tous les boutons standards
  static const double buttonRadius = 12.0;

  /// Rayon de bordure pour les boutons circulaires
  static const double circularRadius = 100.0;
}

/// Bouton élevé avec effet de givrage
class FrostedElevatedButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? elevation;
  final EdgeInsets padding;

  const FrostedElevatedButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        elevation: elevation,
        padding: padding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(FrostedButtonStyle.buttonRadius),
        ),
      ),
      child: child,
    );
  }

  /// Crée un bouton élevé avec une icône
  factory FrostedElevatedButton.icon({
    Key? key,
    required VoidCallback? onPressed,
    required Widget icon,
    required Widget label,
    Color? backgroundColor,
    Color? foregroundColor,
    double? elevation,
    EdgeInsets padding = const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 10,
    ),
  }) {
    return FrostedElevatedButton(
      key: key,
      onPressed: onPressed,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      elevation: elevation,
      padding: padding,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [icon, const SizedBox(width: 8), label],
      ),
    );
  }
}

/// Bouton textuel avec effet de givrage
class FrostedTextButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final Color? foregroundColor;
  final EdgeInsets padding;

  const FrostedTextButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.foregroundColor,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: foregroundColor,
        padding: padding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(FrostedButtonStyle.buttonRadius),
        ),
      ),
      child: child,
    );
  }

  /// Crée un bouton textuel avec une icône
  factory FrostedTextButton.icon({
    Key? key,
    required VoidCallback? onPressed,
    required Widget icon,
    required Widget label,
    Color? foregroundColor,
    EdgeInsets padding = const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 10,
    ),
  }) {
    return FrostedTextButton(
      key: key,
      onPressed: onPressed,
      foregroundColor: foregroundColor,
      padding: padding,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [icon, const SizedBox(width: 8), label],
      ),
    );
  }
}

/// Bouton avec contour avec effet de givrage
class FrostedOutlinedButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final Color? foregroundColor;
  final Color? borderColor;
  final EdgeInsets padding;

  const FrostedOutlinedButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.foregroundColor,
    this.borderColor,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: foregroundColor,
        padding: padding,
        side: borderColor != null ? BorderSide(color: borderColor!) : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(FrostedButtonStyle.buttonRadius),
        ),
      ),
      child: child,
    );
  }

  /// Crée un bouton avec contour avec une icône
  factory FrostedOutlinedButton.icon({
    Key? key,
    required VoidCallback? onPressed,
    required Widget icon,
    required Widget label,
    Color? foregroundColor,
    Color? borderColor,
    EdgeInsets padding = const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 10,
    ),
  }) {
    return FrostedOutlinedButton(
      key: key,
      onPressed: onPressed,
      foregroundColor: foregroundColor,
      borderColor: borderColor,
      padding: padding,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [icon, const SizedBox(width: 8), label],
      ),
    );
  }
}

/// Bouton d'icône avec effet de givrage
class FrostedIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final Color? color;
  final Color? backgroundColor;
  final double size;
  final double? iconSize;

  const FrostedIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.color,
    this.backgroundColor,
    this.size = 40.0,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(FrostedButtonStyle.buttonRadius),
      ),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(FrostedButtonStyle.buttonRadius),
        splashColor: Theme.of(context).splashColor,
        child: Center(
          child: Icon(icon, color: color, size: iconSize ?? size * 0.6),
        ),
      ),
    );
  }
}

/// Bouton d'action flottant avec effet de givrage
class FrostedFloatingActionButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double elevation;
  final bool mini;

  const FrostedFloatingActionButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation = 6.0,
    this.mini = false,
  });

  @override
  Widget build(BuildContext context) {
    // On utilise un border radius standard pour tous les FAB
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      elevation: elevation,
      mini: mini,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(FrostedButtonStyle.buttonRadius),
      ),
      child: child,
    );
  }

  /// Crée un bouton d'action flottant étendu
  static Widget extended({
    Key? key,
    required VoidCallback? onPressed,
    required Widget label,
    Widget? icon,
    Color? backgroundColor,
    Color? foregroundColor,
    double elevation = 6.0,
  }) {
    return FloatingActionButton.extended(
      key: key,
      onPressed: onPressed,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      elevation: elevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(FrostedButtonStyle.buttonRadius),
      ),
      icon: icon,
      label: label,
    );
  }
}

/// Bouton plein (FilledButton) avec style givré
class FrostedFilledButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final EdgeInsets padding;

  const FrostedFilledButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        padding: padding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(FrostedButtonStyle.buttonRadius),
        ),
      ),
      child: child,
    );
  }

  factory FrostedFilledButton.icon({
    Key? key,
    required VoidCallback? onPressed,
    required Widget icon,
    required Widget label,
    Color? backgroundColor,
    Color? foregroundColor,
    EdgeInsets padding = const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 10,
    ),
  }) {
    return FrostedFilledButton(
      key: key,
      onPressed: onPressed,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      padding: padding,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [icon, const SizedBox(width: 8), label],
      ),
    );
  }
}

/// Bouton tonal (FilledButton.tonal) avec style givré
class FrostedTonalButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final EdgeInsets padding;

  const FrostedTonalButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton.tonal(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        padding: padding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(FrostedButtonStyle.buttonRadius),
        ),
      ),
      child: child,
    );
  }

  factory FrostedTonalButton.icon({
    Key? key,
    required VoidCallback? onPressed,
    required Widget icon,
    required Widget label,
    Color? backgroundColor,
    Color? foregroundColor,
    EdgeInsets padding = const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 10,
    ),
  }) {
    return FrostedTonalButton(
      key: key,
      onPressed: onPressed,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      padding: padding,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [icon, const SizedBox(width: 8), label],
      ),
    );
  }
}
