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
  FrostedDrawerMode _drawerMode = FrostedDrawerMode.scrimBlur;

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
      drawerMode: _drawerMode,
      appBar: _hideAppBar
          ? null
          : FrostedAppBar(
              title: currentSection.title,
              leading: Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () => FrostedScaffold.of(context).openDrawer(),
                ),
              ),
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
          // FrostedScaffold2 manages drawer state, we need to close it manually
          // But since we are inside the drawer, context lookup might be tricky if drawer is overlay.
          // However, FrostedNavigationDrawer items usually just fire callback.
          // We need to find the Scaffold2 context.
          // Actually, the drawer is part of the stack, so it should work.
          // BUT wait, we are rebuilding the page state.
          // FrostedScaffold2State has closeDrawer().
          // We can use a GlobalKey or context traversal.
          // Let's try context first.
        },
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(28, 16, 16, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Frosted UI',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(height: 12),
                Text(
                  'Drawer Mode',
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).textTheme.bodySmall?.color,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainerHighest
                        .withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.all(4),
                  child: Row(
                    children: [
                      _buildModeToggleItem(
                        context,
                        'Blur',
                        FrostedDrawerMode.scrimBlur,
                      ),
                      _buildModeToggleItem(
                        context,
                        'Push',
                        FrostedDrawerMode.push,
                      ),
                    ],
                  ),
                ),
              ],
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

  Widget _buildModeToggleItem(
    BuildContext context,
    String label,
    FrostedDrawerMode mode,
  ) {
    final isSelected = _drawerMode == mode;
    final colorScheme = Theme.of(context).colorScheme;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() => _drawerMode = mode);
          // Close drawer after switching mode? Maybe keep it open to see effect?
          // User said "voir le changement". Keep open might be buggy if layout changes drastically.
          // But FrostedScaffold2 handles it.
          // Let's close it to be safe and show the transition next time.
          // Actually, switching mode while open might jump.
          // Let's just setState.
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? colorScheme.surface : Colors.transparent,
            borderRadius: BorderRadius.circular(6),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 2,
                    ),
                  ]
                : null,
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected
                  ? colorScheme.onSurface
                  : colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ),
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
