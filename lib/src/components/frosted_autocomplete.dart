import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:frosted_ui/frosted_ui.dart';

class FrostedAutocomplete<T extends Object> extends StatefulWidget {
  final AutocompleteOptionsBuilder<T> optionsBuilder;
  final AutocompleteOnSelected<T>? onSelected;
  final AutocompleteOptionToString<T> displayStringForOption;
  final Widget Function(BuildContext, T)? optionBuilder;
  final String? hintText;
  final String? labelText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController? textEditingController;
  final FocusNode? focusNode;
  final double borderRadius;

  const FrostedAutocomplete({
    super.key,
    required this.optionsBuilder,
    this.onSelected,
    this.displayStringForOption = RawAutocomplete.defaultStringForOption,
    this.optionBuilder,
    this.hintText,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.textEditingController,
    this.focusNode,
    this.borderRadius = 12.0,
  });

  @override
  State<FrostedAutocomplete<T>> createState() => _FrostedAutocompleteState<T>();
}

class _FrostedAutocompleteState<T extends Object>
    extends State<FrostedAutocomplete<T>> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  OverlayEntry? _overlayEntry;
  Iterable<T> _options = [];
  final LayerLink _layerLink = LayerLink();

  @override
  void initState() {
    super.initState();
    _controller = widget.textEditingController ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();
    _controller.addListener(_onChanged);
    _focusNode.addListener(_onFocusChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onChanged);
    _focusNode.removeListener(_onFocusChanged);
    if (widget.textEditingController == null) _controller.dispose();
    if (widget.focusNode == null) _focusNode.dispose();
    _removeOverlay();
    super.dispose();
  }

  void _onChanged() {
    final value = _controller.value;
    _updateOptions(value);
  }

  void _onFocusChanged() {
    if (_focusNode.hasFocus) {
      _updateOptions(_controller.value);
    } else {
      _removeOverlay();
    }
  }

  Future<void> _updateOptions(TextEditingValue value) async {
    final options = widget.optionsBuilder(value);
    if (options is Future<Iterable<T>>) {
      // Handle async options if needed, for now simplistic
      // Ideally we would show a loading state
      final result = await options;
      if (!mounted) return;
      _updateOverlay(result);
    } else {
      _updateOverlay(options);
    }
  }

  void _updateOverlay(Iterable<T> options) {
    _options = options;
    if (_options.isEmpty || !_focusNode.hasFocus) {
      _removeOverlay();
      return;
    }

    if (_overlayEntry == null) {
      _showOverlay();
    } else {
      _overlayEntry!.markNeedsBuild();
    }
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _showOverlay() {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final viewInsets = mediaQuery.viewInsets; // Clavier

    // Calcul de l'espace disponible
    final spaceBelow =
        screenHeight - (offset.dy + size.height) - viewInsets.bottom;
    final spaceAbove = offset.dy - mediaQuery.padding.top;

    const double estimatedMenuHeight = 200.0; // Max height constraint

    // Décision : Ouvrir en haut si pas de place en bas ET plus de place en haut
    final bool showAbove =
        spaceBelow < estimatedMenuHeight && spaceAbove > spaceBelow;

    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          // Tap outside to dismiss (transparent barrier)
          // Positioned.fill(
          //   child: GestureDetector(
          //     onTap: () {
          //        _removeOverlay();
          //        _focusNode.unfocus();
          //     },
          //     behavior: HitTestBehavior.translucent,
          //     child: Container(color: Colors.transparent),
          //   ),
          // ),
          // Note: RawAutocomplete usually relies on focus loss.
          // If we add a barrier, we block interaction with other widgets.
          // Let's rely on FocusNode listener in _onFocusChanged.
          Positioned(
            width: size.width,
            child: CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: false,
              targetAnchor: showAbove
                  ? Alignment.topLeft
                  : Alignment.bottomLeft,
              followerAnchor: showAbove
                  ? Alignment.bottomLeft
                  : Alignment.topLeft,
              offset: showAbove ? const Offset(0, -5) : const Offset(0, 5),
              child: _buildDropdownMenu(),
            ),
          ),
        ],
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _toggleDropdown() {
    if (_overlayEntry != null) {
      _removeOverlay();
    } else {
      if (!_focusNode.hasFocus) {
        _focusNode.requestFocus();
      }
      // Force update even if no text change to show initial options
      _updateOptions(_controller.value);
    }
  }

  Widget _buildDropdownMenu() {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final bgColor = theme.colorScheme.surface.withValues(alpha: 0.9);

    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(widget.borderRadius),
            border: Border.all(
              color: theme.colorScheme.onSurface.withValues(
                alpha: isDark ? 0.1 : 0.05,
              ),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: theme.shadowColor.withValues(alpha: 0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          constraints: const BoxConstraints(maxHeight: 200),
          child: Material(
            type: MaterialType.transparency,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: _options.length,
              itemBuilder: (context, index) {
                final option = _options.elementAt(index);
                return InkWell(
                  onTap: () {
                    final selection = widget.displayStringForOption(option);
                    _controller.text = selection;
                    _controller.selection = TextSelection.collapsed(
                      offset: selection.length,
                    );
                    _removeOverlay();
                    _focusNode.unfocus();
                    widget.onSelected?.call(option);
                  },
                  child: widget.optionBuilder != null
                      ? widget.optionBuilder!(context, option)
                      : Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          child: Text(
                            widget.displayStringForOption(option),
                            style: theme.textTheme.bodyLarge,
                          ),
                        ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final suffix =
        widget.suffixIcon ??
        IconButton(
          icon: Icon(
            _overlayEntry != null ? Icons.arrow_drop_up : Icons.arrow_drop_down,
          ),
          onPressed: _toggleDropdown,
        );

    return CompositedTransformTarget(
      link: _layerLink,
      child: FrostedTextField(
        controller: _controller,
        focusNode: _focusNode,
        hintText: widget.hintText,
        labelText: widget.labelText,
        prefixIcon: widget.prefixIcon,
        suffixIcon: suffix,
        onTap: () {
          if (_focusNode.hasFocus && _overlayEntry == null) {
            _updateOptions(_controller.value);
          }
        },
      ),
    );
  }
}
