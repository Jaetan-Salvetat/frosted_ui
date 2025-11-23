import 'package:flutter/material.dart';
import 'dart:ui';

class FrostedDropdown<T> extends StatefulWidget {
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final String? hint;
  final Widget? icon;
  final Color? dropdownColor;
  final double borderRadius;

  const FrostedDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    this.hint,
    this.icon,
    this.dropdownColor,
    this.borderRadius = 12.0,
  });

  @override
  State<FrostedDropdown<T>> createState() => _FrostedDropdownState<T>();
}

class _FrostedDropdownState<T> extends State<FrostedDropdown<T>> {
  // Removed _layerLink as we use absolute positioning with CustomSingleChildLayout
  bool _isOpen = false;
  OverlayEntry? _overlayEntry;

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }

  void _toggleDropdown() {
    if (_isOpen) {
      _removeOverlay();
    } else {
      _showOverlay();
    }
    setState(() {
      _isOpen = !_isOpen;
    });
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _showOverlay() {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final offset = renderBox.localToGlobal(Offset.zero);
    final buttonRect = offset & renderBox.size;
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final padding = mediaQuery.padding;

    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          // Modal barrier to close on click outside
          Positioned.fill(
            child: GestureDetector(
              onTap: () {
                _removeOverlay();
                setState(() {
                  _isOpen = false;
                });
              },
              behavior: HitTestBehavior.translucent,
              child: Container(color: Colors.transparent),
            ),
          ),
          // Dropdown menu with custom layout
          CustomSingleChildLayout(
            delegate: _DropdownMenuLayoutDelegate(
              buttonRect: buttonRect,
              screenHeight: screenHeight,
              padding: padding,
            ),
            child: _buildDropdownMenu(),
          ),
        ],
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  Widget _buildDropdownMenu() {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final bgColor =
        widget.dropdownColor ??
        theme.colorScheme.surface.withValues(alpha: 0.9);

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
          constraints: const BoxConstraints(maxHeight: 250),
          child: Material(
            type: MaterialType.transparency,
            child: ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              children: widget.items.map((item) {
                final isSelected = item.value == widget.value;
                return InkWell(
                  onTap: () {
                    if (widget.onChanged != null) {
                      widget.onChanged!(item.value);
                    }
                    _removeOverlay();
                    setState(() {
                      _isOpen = false;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    color: isSelected
                        ? theme.colorScheme.primary.withValues(alpha: 0.1)
                        : Colors.transparent,
                    child: DefaultTextStyle(
                      style: TextStyle(
                        color: isSelected
                            ? theme.colorScheme.primary
                            : theme.textTheme.bodyLarge?.color,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                      child: item.child,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Find selected item widget
    Widget? selectedWidget;
    if (widget.value != null) {
      try {
        selectedWidget = widget.items
            .firstWhere((item) => item.value == widget.value)
            .child;
      } catch (e) {
        // Value not found in items
      }
    }

    return InkWell(
      onTap: _toggleDropdown,
      borderRadius: BorderRadius.circular(widget.borderRadius),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: theme.colorScheme.onSurface.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(widget.borderRadius),
          border: Border.all(
            color: _isOpen
                ? theme.colorScheme.primary.withValues(alpha: 0.5)
                : theme.colorScheme.onSurface.withValues(
                    alpha: isDark ? 0.1 : 0.1,
                  ),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: selectedWidget != null
                  ? DefaultTextStyle(
                      style: theme.textTheme.bodyLarge!,
                      child: selectedWidget,
                    )
                  : Text(
                      widget.hint ?? 'Select...',
                      style: TextStyle(
                        color: theme.textTheme.bodyMedium?.color?.withValues(
                          alpha: 0.6,
                        ),
                      ),
                    ),
            ),
            const SizedBox(width: 8),
            widget.icon ??
                Icon(
                  _isOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                  color: theme.iconTheme.color?.withValues(alpha: 0.7),
                ),
          ],
        ),
      ),
    );
  }
}

class _DropdownMenuLayoutDelegate extends SingleChildLayoutDelegate {
  final Rect buttonRect;
  final double screenHeight;
  final EdgeInsets padding;

  _DropdownMenuLayoutDelegate({
    required this.buttonRect,
    required this.screenHeight,
    required this.padding,
  });

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return constraints.copyWith(
      maxHeight: 250.0,
      minWidth: buttonRect.width,
      maxWidth: buttonRect.width,
    );
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    final double buttonBottom = buttonRect.bottom;
    final double buttonTop = buttonRect.top;

    final double spaceBelow = screenHeight - buttonBottom - padding.bottom;
    final double spaceAbove = buttonTop - padding.top;

    // Prefer below
    bool showBelow = spaceBelow >= childSize.height;

    if (!showBelow && spaceAbove > spaceBelow) {
      // Not enough space below AND more space above -> Show above
      return Offset(buttonRect.left, buttonTop - childSize.height - 5.0);
    }

    // Default: below
    return Offset(buttonRect.left, buttonBottom + 5.0);
  }

  @override
  bool shouldRelayout(_DropdownMenuLayoutDelegate oldDelegate) {
    return buttonRect != oldDelegate.buttonRect ||
        screenHeight != oldDelegate.screenHeight;
  }
}
