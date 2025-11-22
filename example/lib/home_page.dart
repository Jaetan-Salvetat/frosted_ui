import 'package:flutter/material.dart';
import 'package:frosted_ui/frosted_ui.dart';
import 'pages/buttons_demo.dart';
import 'pages/inputs_demo.dart';
import 'pages/selection_demo.dart';
import 'pages/navigation_demo.dart';
import 'pages/feedback_demo.dart';
import 'pages/display_demo.dart';

class ExampleHomePage extends StatefulWidget {
  final VoidCallback onThemeToggle;

  const ExampleHomePage({super.key, required this.onThemeToggle});

  @override
  State<ExampleHomePage> createState() => _ExampleHomePageState();
}

class _ExampleHomePageState extends State<ExampleHomePage> {
  int _selectedIndex = 0;
  bool _hideAppBar = false;

  List<_DemoSection> get _sections => [
    const _DemoSection(
      title: 'Buttons',
      icon: Icons.smart_button,
      child: ButtonsDemo(),
    ),
    const _DemoSection(title: 'Inputs', icon: Icons.input, child: InputsDemo()),
    const _DemoSection(
      title: 'Selection',
      icon: Icons.check_box,
      child: SelectionDemo(),
    ),
    _DemoSection(
      title: 'Navigation',
      icon: Icons.navigation,
      child: NavigationDemo(
        onSliverModeChanged: (isSliver) =>
            setState(() => _hideAppBar = isSliver),
      ),
    ),
    const _DemoSection(
      title: 'Feedback',
      icon: Icons.feedback,
      child: FeedbackDemo(),
    ),
    const _DemoSection(
      title: 'Display',
      icon: Icons.view_quilt,
      child: DisplayDemo(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final currentSection = _sections[_selectedIndex];

    // Gradient background to showcase the frosted effect
    return FrostedScaffold(
      appBar: _hideAppBar
          ? null
          : FrostedAppBar(
              title: currentSection.title,
              actions: [
                FrostedIconButton(
                  icon: isDark ? Icons.light_mode : Icons.dark_mode,
                  onPressed: widget.onThemeToggle,
                ),
              ],
            ),
      drawer: FrostedNavigationDrawer(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
            // Reset app bar visibility when changing page (optional but safer)
            if (index != 3) _hideAppBar = false;
          });
          Navigator.pop(context); // Close drawer
        },
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(28, 16, 16, 10),
            child: Text(
              'Frosted UI',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          const Divider(indent: 28, endIndent: 28),
          ..._sections.asMap().entries.map((entry) {
            return NavigationDrawerDestination(
              icon: Icon(entry.value.icon),
              label: Text(entry.value.title),
            );
          }),
        ],
      ),
      child: currentSection.child,
    );
  }
}

class _DemoSection {
  final String title;
  final IconData icon;
  final Widget child;

  const _DemoSection({
    required this.title,
    required this.icon,
    required this.child,
  });
}
