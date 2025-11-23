import 'package:flutter/material.dart';
import 'package:frosted_ui/frosted_ui.dart';
import '../widgets/section_header.dart';

class InputsDemo extends StatefulWidget {
  const InputsDemo({super.key});

  @override
  State<InputsDemo> createState() => _InputsDemoState();
}

class _InputsDemoState extends State<InputsDemo> {
  bool _switchValue = true;
  bool _checkboxValue = true;
  double _sliderValue = 0.5;
  String? _dropdownValue;
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        SizedBox(height: MediaQuery.of(context).padding.top),
        const SectionHeader('Text Fields'),
        const FrostedTextField(
          hintText: 'Enter some text',
          labelText: 'Label',
          prefixIcon: Icon(Icons.text_fields),
        ),
        const SizedBox(height: 16),
        FrostedTextField(
          hintText: 'Password',
          labelText: 'Password',
          obscureText: _obscureText,
          prefixIcon: Icon(Icons.lock),
          suffixIcon: IconButton(
            onPressed: () => setState(() => _obscureText = !_obscureText),
            icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
          ),
        ),
        const SizedBox(height: 24),
        const SectionHeader('Toggles & Sliders'),
        FrostedCard(
          child: Column(
            children: [
              ListTile(
                title: const Text('Switch'),
                trailing: FrostedSwitch(
                  value: _switchValue,
                  onChanged: (v) => setState(() => _switchValue = v),
                ),
              ),
              ListTile(
                title: const Text('Checkbox'),
                trailing: FrostedCheckbox(
                  value: _checkboxValue,
                  onChanged: (v) => setState(() => _checkboxValue = v!),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Slider: ${_sliderValue.toStringAsFixed(2)}'),
                    const SizedBox(height: 8),
                    FrostedSlider(
                      value: _sliderValue,
                      onChanged: (v) => setState(() => _sliderValue = v),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const SectionHeader('Dropdown'),
        FrostedDropdown<String>(
          value: _dropdownValue,
          hint: 'Select an option',
          items: const [
            DropdownMenuItem(value: 'Option 1', child: Text('Option 1')),
            DropdownMenuItem(value: 'Option 2', child: Text('Option 2')),
            DropdownMenuItem(value: 'Option 3', child: Text('Option 3')),
          ],
          onChanged: (v) => setState(() => _dropdownValue = v),
        ),
        const SizedBox(height: 24),
        const SectionHeader('Autocomplete'),
        FrostedAutocomplete<String>(
          optionsBuilder: (TextEditingValue textEditingValue) {
            const options = [
              'Apple',
              'Banana',
              'Cherry',
              'Date',
              'Elderberry',
              'Fig',
              'Grape',
            ];
            if (textEditingValue.text == '') {
              return options;
            }
            return options.where((String option) {
              return option.toLowerCase().contains(
                textEditingValue.text.toLowerCase(),
              );
            });
          },
          onSelected: (String selection) {
            debugPrint('You selected: $selection');
          },
          hintText: 'Search fruit...',
          prefixIcon: const Icon(Icons.search),
        ),

        // Filler space to push content down
        const SizedBox(height: 400),

        const SectionHeader('Bottom Dropdown (Test Upward)'),
        FrostedDropdown<String>(
          value: _dropdownValue,
          hint: 'Should open upwards',
          items: List.generate(
            10,
            (index) => DropdownMenuItem(
              value: 'Item $index',
              child: Text('Item $index'),
            ),
          ),
          onChanged: (v) => setState(() => _dropdownValue = v),
        ),
        const SizedBox(height: 20), // Just a tiny padding at bottom

        FrostedFilledButton(
          onPressed: () {
            FrostedBottomSheet.show(
              context: context,
              title: 'Dropdown in BottomSheet',
              child: StatefulBuilder(
                builder: (context, setState) {
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 300), // Simulate content
                        const Text('Dropdown below:'),
                        const SizedBox(height: 20),
                        FrostedDropdown<String>(
                          value: _dropdownValue,
                          hint: 'Select in Sheet',
                          items: List.generate(
                            10,
                            (index) => DropdownMenuItem(
                              value: 'Sheet Item $index',
                              child: Text('Sheet Item $index'),
                            ),
                          ),
                          onChanged: (v) {
                            setState(() => _dropdownValue = v);
                            // Also update parent state if needed
                            this.setState(() => _dropdownValue = v);
                          },
                        ),
                        const SizedBox(height: 20), // Bottom padding
                      ],
                    ),
                  );
                },
              ),
            );
          },
          child: const Text('Open Sheet with Dropdown'),
        ),
        const SizedBox(height: 100),
      ],
    );
  }
}
