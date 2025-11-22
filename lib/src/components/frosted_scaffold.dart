import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vm;

class FrostedScaffold extends StatefulWidget {
  final Widget child;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation floatingActionButtonLocation;
  final Color? backgroundColor;
  final Widget? drawer;
  final Widget? endDrawer;
  final Color? drawerScrimColor;
  final double? drawerEdgeDragWidth;
  final bool drawerEnableOpenDragGesture;
  final bool endDrawerEnableOpenDragGesture;
  final bool? resizeToAvoidBottomInset;
  final bool primary;
  final List<Widget>? persistentFooterButtons;
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;
  final Widget? bottomSheet;
  final bool extendBodyBehindAppBar;
  final bool extendBody;
  final double? drawerScrimOpacity;
  final FrostedDrawerMode drawerMode;

  const FrostedScaffold({
    super.key,
    required this.child,
    this.appBar,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation =
        FloatingActionButtonLocation.centerDocked,
    this.backgroundColor,
    this.drawer,
    this.endDrawer,
    this.drawerScrimColor,
    this.drawerEdgeDragWidth,
    this.drawerEnableOpenDragGesture = true,
    this.endDrawerEnableOpenDragGesture = true,
    this.resizeToAvoidBottomInset,
    this.primary = true,
    this.persistentFooterButtons,
    this.floatingActionButtonAnimator,
    this.bottomSheet,
    this.extendBodyBehindAppBar = true,
    this.extendBody = true,
    this.drawerScrimOpacity,
    this.drawerMode = FrostedDrawerMode.scrimBlur,
  });

  static FrostedScaffoldState of(BuildContext context) {
    final result = context.findAncestorStateOfType<FrostedScaffoldState>();
    if (result != null) return result;
    throw FlutterError(
      'FrostedScaffold.of() called with a context that does not contain a FrostedScaffold.',
    );
  }

  @override
  State<FrostedScaffold> createState() => FrostedScaffoldState();
}

enum FrostedDrawerMode {
  /// Full screen blur effect including the scrim area
  scrimBlur,

  /// Side shift effect where the drawer pushes the content
  push,
}

class FrostedScaffoldState extends State<FrostedScaffold>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  static const double _drawerWidth = 300.0; // Standard drawer width

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      reverseDuration: const Duration(milliseconds: 250),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void openDrawer() {
    _animationController.forward();
  }

  void closeDrawer() {
    _animationController.reverse();
  }

  void toggleDrawer() {
    if (_animationController.isCompleted) {
      closeDrawer();
    } else {
      openDrawer();
    }
  }

  bool get isDrawerOpen => _animationController.value > 0.5;

  void _handleDragUpdate(DragUpdateDetails details) {
    if (widget.drawer == null) return;
    _animationController.value += details.primaryDelta! / _drawerWidth;
  }

  void _handleDragEnd(DragEndDetails details) {
    if (widget.drawer == null) return;
    if (_animationController.value > 0.5) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onHorizontalDragUpdate: widget.drawerEnableOpenDragGesture
          ? _handleDragUpdate
          : null,
      onHorizontalDragEnd: widget.drawerEnableOpenDragGesture
          ? _handleDragEnd
          : null,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          final double slide = _drawerWidth * _animationController.value;

          Widget bodyContent = Scaffold(
            extendBodyBehindAppBar: widget.extendBodyBehindAppBar,
            extendBody: widget.extendBody,
            appBar: widget.appBar,
            bottomNavigationBar: widget.bottomNavigationBar,
            body: widget.child,
            floatingActionButton: widget.floatingActionButton,
            floatingActionButtonLocation: widget.floatingActionButtonLocation,
            backgroundColor: widget.backgroundColor,
            // We don't pass drawer here to handle it manually
            endDrawer: widget.endDrawer,
            drawerScrimColor: widget.drawerScrimColor,
            endDrawerEnableOpenDragGesture:
                widget.endDrawerEnableOpenDragGesture,
            resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
            primary: widget.primary,
            persistentFooterButtons: widget.persistentFooterButtons,
            floatingActionButtonAnimator: widget.floatingActionButtonAnimator,
            bottomSheet: widget.bottomSheet,
          );

          // Apply Push Effect transform
          if (widget.drawerMode == FrostedDrawerMode.push) {
            bodyContent = Transform(
              transform: Matrix4.identity()
                ..translateByVector3(vm.Vector3(slide, 0, 0)),
              alignment: Alignment.centerLeft,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                  32 * _animationController.value,
                ),
                child: bodyContent,
              ),
            );
          }

          return Stack(
            children: [
              // Background (visible in Push mode)
              if (widget.drawerMode == FrostedDrawerMode.push)
                Positioned.fill(
                  child: Container(color: theme.scaffoldBackgroundColor),
                ),

              // Drawer (Behind body for Push, On top for ScrimBlur)
              if (widget.drawer != null &&
                  widget.drawerMode == FrostedDrawerMode.push)
                Positioned(
                  top: 0,
                  bottom: 0,
                  left: 0,
                  width: _drawerWidth,
                  child: widget.drawer!,
                ),

              // Main Body
              Positioned.fill(child: bodyContent),

              // Scrim + Blur (For ScrimBlur mode)
              if (widget.drawerMode == FrostedDrawerMode.scrimBlur &&
                  _animationController.value > 0)
                Positioned.fill(
                  child: GestureDetector(
                    onTap: closeDrawer,
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 10 * _animationController.value,
                        sigmaY: 10 * _animationController.value,
                      ),
                      child: Container(
                        color: Colors.black.withAlpha(
                          (0.2 * _animationController.value * 255).toInt(),
                        ),
                      ),
                    ),
                  ),
                ),

              // Drawer (On top for ScrimBlur mode)
              if (widget.drawer != null &&
                  widget.drawerMode == FrostedDrawerMode.scrimBlur)
                Positioned(
                  top: 0,
                  bottom: 0,
                  left: -_drawerWidth + slide,
                  width: _drawerWidth,
                  child: widget.drawer!,
                ),
            ],
          );
        },
      ),
    );
  }
}
