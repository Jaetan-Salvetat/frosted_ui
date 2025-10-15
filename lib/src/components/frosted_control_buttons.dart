import 'package:flutter/material.dart';
import 'frosted_buttons.dart';

/// Boutons de contrôle circulaires
class FrostedControlButton extends StatelessWidget {
  /// Le texte ou chiffre à afficher dans le bouton
  final String? text;
  
  /// L'icône à afficher dans le bouton
  final IconData? icon;
  
  /// Fonction appelée lorsque le bouton est pressé
  final VoidCallback? onPressed;
  
  /// Couleur d'arrière-plan du bouton
  final Color? backgroundColor;
  
  /// Couleur du contenu (texte ou icône)
  final Color? foregroundColor;
  
  /// Taille du bouton
  final double size;
  
  /// Taille du texte ou de l'icône
  final double? contentSize;
  
  /// Style du texte
  final TextStyle? textStyle;
  
  const FrostedControlButton({
    super.key,
    this.text,
    this.icon,
    required this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
    this.size = 40.0,
    this.contentSize,
    this.textStyle,
  }) : assert(text != null || icon != null, 'Either text or icon must be provided');

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bgColor = backgroundColor ?? theme.colorScheme.surfaceVariant;
    final fgColor = foregroundColor ?? theme.colorScheme.onSurfaceVariant;
    
    return SizedBox(
      width: size,
      height: size,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: fgColor,
          padding: EdgeInsets.zero,
          shape: const CircleBorder(),
          elevation: 0,
        ),
        child: _buildContent(fgColor),
      ),
    );
  }
  
  Widget _buildContent(Color foregroundColor) {
    if (text != null) {
      return Text(
        text!,
        style: textStyle?.copyWith(
          color: foregroundColor,
          fontSize: contentSize,
        ) ?? TextStyle(
          color: foregroundColor,
          fontSize: contentSize ?? size * 0.5,
          fontWeight: FontWeight.bold,
        ),
      );
    } else {
      return Icon(
        icon,
        color: foregroundColor,
        size: contentSize ?? size * 0.6,
      );
    }
  }
}

/// Groupe de boutons de sélection à style de givrage
class FrostedToggleButtons extends StatelessWidget {
  final List<Widget> children;
  final List<bool> isSelected;
  final void Function(int)? onPressed;
  final Color? selectedColor;
  final Color? unselectedColor;
  final Color? selectedBorderColor;
  final Color? unselectedBorderColor;
  final double borderRadius;
  
  const FrostedToggleButtons({
    super.key,
    required this.children,
    required this.isSelected,
    this.onPressed,
    this.selectedColor,
    this.unselectedColor,
    this.selectedBorderColor,
    this.unselectedBorderColor,
    this.borderRadius = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      isSelected: isSelected,
      onPressed: onPressed,
      selectedColor: selectedColor,
      color: unselectedColor,
      selectedBorderColor: selectedBorderColor,
      borderColor: unselectedBorderColor,
      borderRadius: BorderRadius.circular(borderRadius),
      children: children,
    );
  }
}

/// Bouton de menu avec label
class FrostedMenuButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool isSelected;
  
  const FrostedMenuButton({
    super.key,
    required this.label,
    this.icon,
    required this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
    this.isSelected = false,
  });
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Color bg = backgroundColor ?? 
        (isSelected ? theme.colorScheme.primary : theme.colorScheme.surfaceVariant.withOpacity(0.7));
    Color fg = foregroundColor ?? 
        (isSelected ? theme.colorScheme.onPrimary : theme.colorScheme.onSurfaceVariant);
    
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: bg,
        foregroundColor: fg,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(FrostedButtonStyle.buttonRadius),
        ),
        elevation: 0,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 18),
            const SizedBox(width: 8),
          ],
          Text(label),
        ],
      ),
    );
  }
}
