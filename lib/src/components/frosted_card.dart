import 'package:flutter/material.dart';

/// Card avec design moderne et épuré inspiré de l'esthétique givré
class FrostedCard extends StatelessWidget {
  /// Contenu de la carte
  final Widget child;

  /// Fonction appelée lorsque la carte est touchée (optionnel)
  final VoidCallback? onClick;

  /// Rayon des coins de la carte
  final double borderRadius;

  /// Padding interne du contenu
  final EdgeInsets padding;

  /// Marge externe de la carte
  final EdgeInsets margin;

  /// Si défini à true, la carte prendra toute la largeur disponible
  final bool fullWidth;

  /// Couleur d'accentuation (optionnelle)
  final Color? accentColor;

  const FrostedCard({
    required this.child,
    this.onClick,
    this.borderRadius = 12.0,
    this.padding = const EdgeInsets.all(16.0),
    this.margin = const EdgeInsets.all(0.0),
    this.fullWidth = false,
    this.accentColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Fond uni comme demandé
    final Color backgroundColor = colorScheme.surface;

    final Color borderColor = colorScheme.onSurface.withValues(
      alpha: isDark ? 0.1 : 0.05,
    );

    final BorderRadius cardBorderRadius = BorderRadius.circular(borderRadius);

    Widget cardContent = Container(
      padding: padding,
      width: fullWidth ? double.infinity : null,
      child: child,
    );

    Widget card = Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: cardBorderRadius,
        boxShadow: [
          // Ombre légère
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: isDark ? 0.3 : 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
            spreadRadius: 0,
          ),
        ],
        border: Border.all(color: borderColor, width: 0.5),
      ),
      child: ClipRRect(borderRadius: cardBorderRadius, child: cardContent),
    );

    if (onClick != null) {
      return Padding(
        padding: margin,
        child: Material(
          color: Colors.transparent,
          borderRadius: cardBorderRadius,
          child: InkWell(
            onTap: onClick,
            borderRadius: cardBorderRadius,
            splashColor: (accentColor ?? colorScheme.primary).withValues(
              alpha: 0.1,
            ),
            highlightColor: (accentColor ?? colorScheme.primary).withValues(
              alpha: 0.05,
            ),
            child: card,
          ),
        ),
      );
    }

    return Padding(padding: margin, child: card);
  }
}
