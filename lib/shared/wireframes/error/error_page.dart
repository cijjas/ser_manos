import 'package:flutter/material.dart';
import '../../../utils/app_strings.dart';

class ErrorPage extends StatelessWidget {
  final String? message;

  const ErrorPage({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.strings.error)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                message ?? context.strings.unexpectedError,
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => Navigator.of(context).maybePop(),
                child: Text(context.strings.goBack),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
