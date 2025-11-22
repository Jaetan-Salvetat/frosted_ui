import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FrostedTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final bool autofocus;
  final FocusNode? focusNode;
  final int? maxLines;
  final int? minLines;
  final bool readOnly;
  final VoidCallback? onTap;
  final String? errorText;
  final Color? accentColor;

  const FrostedTextField({
    super.key,
    this.controller,
    this.hintText,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.inputFormatters,
    this.autofocus = false,
    this.focusNode,
    this.maxLines = 1,
    this.minLines,
    this.readOnly = false,
    this.onTap,
    this.errorText,
    this.accentColor,
  });

  @override
  State<FrostedTextField> createState() => _FrostedTextFieldState();
}

class _FrostedTextFieldState extends State<FrostedTextField> {
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    } else {
      _focusNode.removeListener(_handleFocusChange);
    }
    super.dispose();
  }

  void _handleFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    final primaryColor = widget.accentColor ?? colorScheme.primary;
    final errorColor = colorScheme.error;

    // Couleurs de fond
    final baseColor = isDark
        ? colorScheme.surfaceContainerLow
        : colorScheme.surfaceContainer;

    final backgroundColor = _isFocused
        ? baseColor.withOpacity(isDark ? 0.8 : 0.9)
        : baseColor.withOpacity(isDark ? 0.6 : 0.7);

    // Bordure
    final borderColor = widget.errorText != null
        ? errorColor.withOpacity(0.5)
        : _isFocused
        ? primaryColor.withOpacity(0.5)
        : isDark
        ? Colors.white.withOpacity(0.1)
        : Colors.black.withOpacity(0.05);

    // Glow effect (ombre portée colorée)
    final List<BoxShadow> shadows = [];
    if (_isFocused || widget.errorText != null) {
      final glowColor = widget.errorText != null ? errorColor : primaryColor;
      shadows.add(
        BoxShadow(
          color: glowColor.withOpacity(0.15),
          blurRadius: 8,
          spreadRadius: 0,
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.labelText != null) ...[
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 8),
            child: Text(
              widget.labelText!,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: widget.errorText != null
                    ? errorColor
                    : _isFocused
                    ? primaryColor
                    : theme.textTheme.bodyMedium?.color?.withOpacity(0.8),
              ),
            ),
          ),
        ],

        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: borderColor,
              width: _isFocused || widget.errorText != null ? 1.5 : 1.0,
            ),
            boxShadow: shadows,
          ),
          child: TextField(
            controller: widget.controller,
            focusNode: _focusNode,
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: TextStyle(
                color: theme.textTheme.bodyMedium?.color?.withValues(
                  alpha: 0.4,
                ),
              ),
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.suffixIcon,
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              isDense: true,
            ),
            obscureText: widget.obscureText,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            onChanged: widget.onChanged,
            onEditingComplete: widget.onEditingComplete,
            onSubmitted: widget.onSubmitted,
            inputFormatters: widget.inputFormatters,
            autofocus: widget.autofocus,
            maxLines: widget.maxLines,
            minLines: widget.minLines,
            readOnly: widget.readOnly,
            onTap: widget.onTap,
            style: TextStyle(
              color: theme.textTheme.bodyLarge?.color,
              fontSize: 16,
            ),
            cursorColor: primaryColor,
            cursorOpacityAnimates: true,
          ),
        ),

        if (widget.errorText != null) ...[
          Padding(
            padding: const EdgeInsets.only(left: 4, top: 6),
            child: Text(
              widget.errorText!,
              style: TextStyle(
                fontSize: 12,
                color: errorColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
