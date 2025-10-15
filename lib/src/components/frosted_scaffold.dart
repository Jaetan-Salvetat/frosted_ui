import 'dart:ui';
import 'package:flutter/material.dart';

class FrostedScaffold extends StatelessWidget {
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
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      extendBody: extendBody,
      appBar: appBar,
      bottomNavigationBar: bottomNavigationBar,
      body: child,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      backgroundColor: backgroundColor,
      drawer: drawer,
      endDrawer: endDrawer,
      drawerScrimColor: drawerScrimColor,
      drawerEdgeDragWidth: drawerEdgeDragWidth,
      drawerEnableOpenDragGesture: drawerEnableOpenDragGesture,
      endDrawerEnableOpenDragGesture: endDrawerEnableOpenDragGesture,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      primary: primary,
      persistentFooterButtons: persistentFooterButtons,
      floatingActionButtonAnimator: floatingActionButtonAnimator,
      bottomSheet: bottomSheet,
    );
  }
}
