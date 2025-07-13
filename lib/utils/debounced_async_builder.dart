import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DebouncedAsyncBuilder<T> extends StatefulWidget {
  final AsyncValue<T> asyncValue;
  final Widget Function(T data) dataBuilder;
  final Widget Function() loadingBuilder;
  final Widget Function(Object error, StackTrace? stackTrace) errorBuilder;
  final Duration errorDebounceDelay;
  final bool skipLoadingOnRefresh;
  final void Function(Object error, StackTrace? stackTrace)? onError;
  final int maxRetries;

  const DebouncedAsyncBuilder({
    super.key,
    required this.asyncValue,
    required this.dataBuilder,
    required this.loadingBuilder,
    required this.errorBuilder,
    this.errorDebounceDelay = const Duration(seconds: 2),
    this.skipLoadingOnRefresh = true,
    this.onError,
    this.maxRetries = 3,
  });

  @override
  State<DebouncedAsyncBuilder<T>> createState() => _DebouncedAsyncBuilderState<T>();
}

class _DebouncedAsyncBuilderState<T> extends State<DebouncedAsyncBuilder<T>> {
  Timer? _errorDebounceTimer;
  bool _showDebouncedError = false;
  Object? _lastError;
  int _retryCount = 0;

  @override
  void dispose() {
    _errorDebounceTimer?.cancel();
    super.dispose();
  }

  void _handleError(Object error, StackTrace? stackTrace) {
    if (_lastError != error) {
      _lastError = error;
      _retryCount = 0;
      _showDebouncedError = false;
      _errorDebounceTimer?.cancel();
    }

    if (_retryCount < widget.maxRetries) {
      widget.onError?.call(error, stackTrace);
      _retryCount++;
    }

    if (!_showDebouncedError && _errorDebounceTimer == null) {
      _errorDebounceTimer = Timer(widget.errorDebounceDelay, () {
        if (mounted) {
          setState(() {
            _showDebouncedError = true;
          });
        }
      });
    }
  }

  void _resetErrorState() {
    _errorDebounceTimer?.cancel();
    _showDebouncedError = false;
    _lastError = null;
    _retryCount = 0;
  }

  @override
  Widget build(BuildContext context) {
    return widget.asyncValue.when(
      skipLoadingOnRefresh: widget.skipLoadingOnRefresh,
      data: (data) {
        _resetErrorState();
        return widget.dataBuilder(data);
      },
      error: (error, stackTrace) {
        _handleError(error, stackTrace);

        if (_showDebouncedError) {
          return widget.errorBuilder(error, stackTrace);
        } else {
          return widget.loadingBuilder();
        }
      },
      loading: () => widget.loadingBuilder(),
    );
  }
}

extension AsyncValueDebouncedExtension<T> on AsyncValue<T> {
  Widget whenDebounced({
    required Widget Function(T data) data,
    required Widget Function() loading,
    required Widget Function(Object error, StackTrace? stackTrace) error,
    Duration errorDebounceDelay = const Duration(seconds: 2),
    bool skipLoadingOnRefresh = true,
    void Function(Object error, StackTrace? stackTrace)? onError,
    int maxRetries = 3,
  }) {
    return DebouncedAsyncBuilder<T>(
      asyncValue: this,
      dataBuilder: data,
      loadingBuilder: loading,
      errorBuilder: error,
      errorDebounceDelay: errorDebounceDelay,
      skipLoadingOnRefresh: skipLoadingOnRefresh,
      onError: onError,
      maxRetries: maxRetries,
    );
  }
}
