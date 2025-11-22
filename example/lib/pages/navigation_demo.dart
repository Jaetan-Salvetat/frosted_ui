import 'package:flutter/material.dart';
import 'package:frosted_ui/frosted_ui.dart';

class NavigationDemo extends StatefulWidget {
  final ValueChanged<bool>? onSliverModeChanged;

  const NavigationDemo({super.key, this.onSliverModeChanged});

  @override
  State<NavigationDemo> createState() => _NavigationDemoState();
}

class _NavigationDemoState extends State<NavigationDemo> {
  bool _showBottomBar = true;
  bool _useSliverAppBar = false;
  bool _showTabs = false;
  int _navIndex = 0;
  int _tabIndex = 0;

  @override
  void dispose() {
    // Reset parent app bar when leaving
    widget.onSliverModeChanged?.call(false);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double topPadding = _useSliverAppBar
        ? 0
        : MediaQuery.of(context).padding.top + kToolbarHeight;

    return FrostedScaffold(
      // Parent scaffold already has an app bar, so we don't need one here unless testing Sliver
      appBar: null,
      bottomNavigationBar: _showBottomBar
          ? FrostedBottomNavigationBar(
              currentIndex: _navIndex,
              onTap: (i) => setState(() => _navIndex = i),
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: 'Search',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
            )
          : null,
      child: CustomScrollView(
        slivers: [
          if (_useSliverAppBar)
            FrostedSliverAppBar(
              title: 'Sliver Navigation Demo',
              expandedHeight: 200,
              showBackButton: false,
              leading: IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),
          if (!_useSliverAppBar)
            SliverToBoxAdapter(child: SizedBox(height: topPadding + 16)),
          // Config Panel
          SliverToBoxAdapter(
            child: FrostedCard(
              margin: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Configuration',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16),
                  SwitchListTile(
                    title: const Text('Show Bottom Bar'),
                    value: _showBottomBar,
                    onChanged: (v) => setState(() => _showBottomBar = v),
                  ),
                  SwitchListTile(
                    title: const Text('Use Sliver App Bar'),
                    value: _useSliverAppBar,
                    onChanged: (v) {
                      setState(() => _useSliverAppBar = v);
                      widget.onSliverModeChanged?.call(v);
                    },
                  ),
                  SwitchListTile(
                    title: const Text('Show Tabs'),
                    value: _showTabs,
                    onChanged: (v) => setState(() => _showTabs = v),
                  ),
                ],
              ),
            ),
          ),
          if (_showTabs)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: FrostedTabs(
                  tabs: const ['Tab 1', 'Tab 2', 'Tab 3'],
                  selectedIndex: _tabIndex,
                  onTabSelected: (i) => setState(() => _tabIndex = i),
                ),
              ),
            ),
          if (_showTabs) const SliverToBoxAdapter(child: SizedBox(height: 16)),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => ListTile(
                title: Text('Content Item $index'),
                subtitle: const Text('Scroll to see the frosted effect'),
              ),
              childCount: 50,
            ),
          ),
        ],
      ),
    );
  }
}
