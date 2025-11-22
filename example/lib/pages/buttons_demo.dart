import 'package:flutter/material.dart';
import 'package:frosted_ui/frosted_ui.dart';
import '../widgets/section_header.dart';

class ButtonsDemo extends StatelessWidget {
  const ButtonsDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        SizedBox(height: MediaQuery.of(context).padding.top),
        const SectionHeader('Common Buttons'),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            FrostedElevatedButton(
              onPressed: () {},
              child: const Text('Elevated'),
            ),
            FrostedFilledButton(onPressed: () {}, child: const Text('Filled')),
            FrostedTonalButton(onPressed: () {}, child: const Text('Tonal')),
            FrostedOutlinedButton(
              onPressed: () {},
              child: const Text('Outlined'),
            ),
            FrostedTextButton(onPressed: () {}, child: const Text('Text')),
          ],
        ),
        const SizedBox(height: 24),
        const SectionHeader('Buttons with Icons'),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            FrostedElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text('Create'),
            ),
            FrostedFilledButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.send),
              label: const Text('Send'),
            ),
            FrostedOutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.delete),
              label: const Text('Delete'),
            ),
          ],
        ),
        const SizedBox(height: 24),
        const SectionHeader('Icon Buttons'),
        Row(
          children: [
            FrostedIconButton(icon: Icons.favorite, onPressed: () {}),
            const SizedBox(width: 16),
            FrostedIconButton(
              icon: Icons.share,
              onPressed: () {},
              backgroundColor: Theme.of(
                context,
              ).colorScheme.primary.withValues(alpha: 0.1),
              color: Theme.of(context).colorScheme.primary,
            ),
          ],
        ),
        const SizedBox(height: 24),
        const SectionHeader('Control & Menu Buttons'),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            FrostedControlButton(text: '1', onPressed: () {}),
            FrostedControlButton(icon: Icons.chevron_left, onPressed: () {}),
            FrostedMenuButton(
              label: 'Menu Item',
              icon: Icons.star,
              onPressed: () {},
            ),
            FrostedMenuButton(
              label: 'Selected',
              icon: Icons.check,
              isSelected: true,
              onPressed: () {},
            ),
          ],
        ),
        const SizedBox(height: 24),
        const SectionHeader('Floating Action Buttons'),
        Row(
          children: [
            FrostedFloatingActionButton(
              onPressed: () {},
              child: const Icon(Icons.add),
            ),
            const SizedBox(width: 16),
            FrostedFloatingActionButton.extended(
              onPressed: () {},
              icon: const Icon(Icons.edit),
              label: const Text('Compose'),
            ),
          ],
        ),
      ],
    );
  }
}
