import 'package:flutter/material.dart';

import 'frosted_buttons.dart';

/// Groupe de boutons de sélection à style de givrage
class FrostedToggleButtons extends StatelessWidget {
  /// Les widgets enfants à afficher dans chaque bouton
  final List<Widget> children;

  /// L'état de sélection de chaque bouton
  final List<bool> isSelected;

  /// Fonction appelée lorsqu'un bouton est pressé
  final void Function(int)? onPressed;

  /// Couleur des boutons sélectionnés
  final Color? selectedColor;

  /// Couleur des boutons non sélectionnés
  final Color? unselectedColor;

  /// Couleur de la bordure des boutons sélectionnés
  final Color? selectedBorderColor;

  /// Couleur de la bordure des boutons non sélectionnés
  final Color? unselectedBorderColor;
  
  const FrostedToggleButtons({
    super.key,
    required this.children,
    required this.isSelected,
    this.onPressed,
    this.selectedColor,
    this.unselectedColor,
    this.selectedBorderColor,
    this.unselectedBorderColor,
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
      borderRadius: BorderRadius.circular(FrostedButtonStyle.buttonRadius),
      children: children,
    );
  }
}
