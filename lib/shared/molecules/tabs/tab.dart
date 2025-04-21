import 'package:flutter/material.dart';

class AppTab extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final bool isSelected;

  const AppTab({
    super.key,
    required this.label,
    this.onTap,
    this.isSelected = false, // Default to not selected
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120, // Set the desired width
      child: MaterialButton(
        onPressed: onTap, // Trigger the external state change
        color: isSelected
            ? Theme.of(context).colorScheme.secondary // Active state color
            : Theme.of(context).colorScheme.onSecondaryContainer, // Default color
        splashColor: Theme.of(context).colorScheme.onSurface.withAlpha(25),
        elevation: 0, // Removes default shadow
        highlightElevation: 0, // Removes highlight shadow
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: isSelected
                ? Theme.of(context).colorScheme.onPrimary // Active text color
                : Theme.of(context).colorScheme.surfaceContainer, // Default text color
          ),
        ),
      ),
    );
  }
}