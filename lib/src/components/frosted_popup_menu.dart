import 'package:flutter/material.dart';
import 'dart:ui';

class FrostedPopupMenu<T> extends StatefulWidget {
  final List<FrostedPopupMenuItem<T>> items;
  final void Function(T)? onSelected;
  final Widget child;
  final double borderRadius;

  const FrostedPopupMenu({
    super.key,
    required this.items,
    required this.child,
    this.onSelected,
    this.borderRadius = 12.0,
  });

  @override
  State<FrostedPopupMenu<T>> createState() => _FrostedPopupMenuState<T>();
}

class _FrostedPopupMenuState<T> extends State<FrostedPopupMenu<T>> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }

  void _toggleMenu() {
    if (_isOpen) {
      _closeMenu();
    } else {
      _openMenu();
    }
  }

  void _closeMenu() {
    _removeOverlay();
    if (mounted) {
      setState(() {
        _isOpen = false;
      });
    }
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _openMenu() {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: _closeMenu,
              behavior: HitTestBehavior.translucent,
              child: Container(color: Colors.transparent),
            ),
          ),
          Positioned(
            child: CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: false,
              offset: Offset(0.0, size.height + 5.0),
              child: _buildMenu(),
            ),
          ),
        ],
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
    setState(() {
      _isOpen = true;
    });
  }

  Widget _buildMenu() {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final bgColor = theme.colorScheme.surface.withValues(alpha: 0.9);

    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: IntrinsicWidth(
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
            child: Material(
              type: MaterialType.transparency,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: widget.items.map((item) {
                  return InkWell(
                    onTap: () {
                      if (widget.onSelected != null) {
                        widget.onSelected!(item.value);
                      }
                      _closeMenu();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      child: Row(
                        children: [
                          if (item.icon != null) ...[
                            item.icon!,
                            const SizedBox(width: 12),
                          ],
                          Expanded(
                            child: DefaultTextStyle(
                              style: theme.textTheme.bodyMedium!,
                              child: item.child,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(onTap: _toggleMenu, child: widget.child),
    );
  }
}

class FrostedPopupMenuItem<T> {
  final T value;
  final Widget child;
  final Widget? icon;

  const FrostedPopupMenuItem({
    required this.value,
    required this.child,
    this.icon,
  });
}
