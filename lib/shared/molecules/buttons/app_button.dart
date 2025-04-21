// core/components/app_button.dart
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  const AppButton.filled({
    super.key,
    required this.label,
    required this.onPressed,
  }) : _filled = true;

  const AppButton.tonal({
    super.key,
    required this.label,
    required this.onPressed,
  }) : _filled = false;

  final bool _filled;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final bool isDisabled = onPressed == null;

    final ButtonStyle style = ButtonStyle(
      minimumSize: WidgetStateProperty.all(const Size(328, 44)),
      padding: WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: 16)),
      textStyle: WidgetStateProperty.all(Theme.of(context).textTheme.labelLarge),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (!_filled || isDisabled) return Colors.transparent;
        return colorScheme.primary;
      }),
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        if (!_filled) {
          return isDisabled ? colorScheme.onSurface : colorScheme.primary;
        }
        return colorScheme.onPrimary;
      }),
      overlayColor: WidgetStateProperty.all(
        _filled ? colorScheme.surfaceContainerHighest : colorScheme.outline,
      ),
    );

    return TextButton(
      onPressed: onPressed,
      style: style,
      child: Text(label),
    );
  }
}
