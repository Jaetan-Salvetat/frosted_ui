import 'package:flutter/material.dart';
import 'package:frosted_ui/frosted_ui.dart';
import '../widgets/section_header.dart';

class SelectionDemo extends StatefulWidget {
  const SelectionDemo({super.key});

  @override
  State<SelectionDemo> createState() => _SelectionDemoState();
}

class _SelectionDemoState extends State<SelectionDemo> {
  final List<bool> _toggleSelection = [true, false, false];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        SizedBox(height: MediaQuery.of(context).padding.top),
        const SectionHeader('Toggle Buttons'),
        Center(
          child: FrostedToggleButtons(
            isSelected: _toggleSelection,
            onPressed: (index) {
              setState(() {
                // Basic toggle logic (radio style)
                for (int i = 0; i < _toggleSelection.length; i++) {
                  _toggleSelection[i] = i == index;
                }
              });
            },
            children: const [
              Icon(Icons.format_align_left),
              Icon(Icons.format_align_center),
              Icon(Icons.format_align_right),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const SectionHeader('Chips'),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            FrostedChip(label: const Text('Action Chip'), onPressed: () {}),
            const FrostedChip(label: Text('Selected Chip'), selected: true),
            FrostedChip(label: const Text('Delete Me'), onDeleted: () {}),
            const FrostedChip(
              label: Text('With Icon'),
              avatar: Icon(Icons.face),
            ),
          ],
        ),
        const SizedBox(height: 24),
        const SectionHeader('Popup Menu'),
        Center(
          child: FrostedPopupMenu<String>(
            items: const [
              FrostedPopupMenuItem(value: '1', child: Text('Item 1')),
              FrostedPopupMenuItem(
                value: '2',
                child: Text('Item 2 plus long que les autres'),
              ),
              FrostedPopupMenuItem(value: '3', child: Text('Item 3')),
            ],
            onSelected: (v) {},
            child: const FrostedCard(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Text('Click me to open Menu'),
            ),
          ),
        ),
      ],
    );
  }
}
