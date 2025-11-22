import 'package:flutter/material.dart';
import 'package:frosted_ui/frosted_ui.dart';
import '../widgets/section_header.dart';

class FeedbackDemo extends StatelessWidget {
  const FeedbackDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        SizedBox(height: MediaQuery.of(context).padding.top),
        const SectionHeader('Progress Indicators'),
        const Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FrostedCircularProgressIndicator(value: 0.7),
              FrostedCircularProgressIndicator(value: 0.3, size: 60),
              FrostedCircularProgressIndicator(), // Indeterminate
            ],
          ),
        ),
        const SizedBox(height: 24),
        const FrostedLinearProgressIndicator(value: 0.6),
        const SizedBox(height: 16),
        const FrostedLinearProgressIndicator(), // Indeterminate
        const SizedBox(height: 24),
        const SectionHeader('Dialogs'),
        Center(
          child: FrostedElevatedButton(
            onPressed: () {
              FrostedDialog.show(
                context: context,
                title: const Text('Frosted Dialog'),
                content: const Text(
                  'This is a dialog with frosted glass effect.',
                ),
                actions: [
                  FrostedTextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  FrostedFilledButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('OK'),
                  ),
                ],
              );
            },
            child: const Text('Show Dialog'),
          ),
        ),
        const SizedBox(height: 16),
        Center(
          child: FrostedElevatedButton(
            onPressed: () {
              bool termsAccepted = false;
              bool notificationsEnabled = true;

              FrostedDialog.show(
                context: context,
                title: const Text('Form Dialog'),
                content: StatefulBuilder(
                  builder: (context, setState) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const FrostedTextField(
                          hintText: 'Full Name',
                          prefixIcon: Icon(Icons.person),
                        ),
                        const SizedBox(height: 16),
                        const FrostedTextField(
                          hintText: 'Email Address',
                          prefixIcon: Icon(Icons.email),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            FrostedSwitch(
                              value: notificationsEnabled,
                              onChanged: (value) {
                                setState(() => notificationsEnabled = value);
                              },
                            ),
                            const SizedBox(width: 12),
                            const Text('Receive Notifications'),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            FrostedCheckbox(
                              value: termsAccepted,
                              onChanged: (value) {
                                setState(() => termsAccepted = value ?? false);
                              },
                            ),
                            const SizedBox(width: 12),
                            const Text('I agree to terms'),
                          ],
                        ),
                      ],
                    );
                  },
                ),
                actions: [
                  FrostedTextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  FrostedFilledButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Submit'),
                  ),
                ],
              );
            },
            child: const Text('Show Form Dialog'),
          ),
        ),
        const SizedBox(height: 24),
        const SectionHeader('Bottom Sheet'),
        Center(
          child: FrostedElevatedButton(
            onPressed: () {
              FrostedBottomSheet.show(
                context: context,
                title: 'Frosted Bottom Sheet',
                child: const SizedBox(
                  height: 200,
                  child: Center(
                    child: Text('This is a frosted bottom sheet content'),
                  ),
                ),
              );
            },
            child: const Text('Show Bottom Sheet'),
          ),
        ),
        const SizedBox(height: 24),
        const SectionHeader('Snackbar'),
        Center(
          child: FrostedElevatedButton(
            onPressed: () {
              FrostedSnackbar.show(
                context,
                message: 'This is a frosted snackbar!',
              );
            },
            child: const Text('Show Snackbar'),
          ),
        ),
        const SizedBox(height: 24),
        const SectionHeader('Tooltip'),
        const Center(
          child: FrostedTooltip(
            message: 'This is a tooltip',
            child: FrostedCard(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Long Press Me'),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
