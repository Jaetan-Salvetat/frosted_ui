import 'package:flutter/material.dart';
import 'package:frosted_ui/frosted_ui.dart';
import '../widgets/section_header.dart';

class DisplayDemo extends StatelessWidget {
  const DisplayDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        SizedBox(height: MediaQuery.of(context).padding.top),
        const SectionHeader('Cards'),
        const FrostedCard(
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.album),
                title: Text('Frosted Card'),
                subtitle: Text('With a list tile inside'),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Cards can contain any content and adapt to the background.',
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const SectionHeader('List Tiles'),
        const FrostedCard(
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              FrostedListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
                trailing: Icon(Icons.chevron_right),
              ),
              FrostedDivider(),
              FrostedListTile(
                leading: Icon(Icons.info),
                title: Text('About'),
                trailing: Icon(Icons.chevron_right),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const SectionHeader('Badge'),
        const Center(
          child: FrostedBadge(
            label: 'New',
            child: Icon(Icons.notifications, size: 40),
          ),
        ),
      ],
    );
  }
}
