import 'dart:async';
import 'dart:developer' as dev;

import 'package:flutter/material.dart';

/// Entry point
void main() => runZonedGuarded<void>(
      () => runApp(const App()),
      (error, stackTrace) => dev.log(
        'A error has occurred',
        stackTrace: stackTrace,
        error: error,
        name: 'main',
        level: 1000,
      ),
    );

/// {@template app}
/// App widget
/// {@endtemplate}
class App extends StatelessWidget {
  /// {@macro app}
  const App({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Promter',
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Promter'),
          ),
          body: const SafeArea(
            child: Placeholder(),
          ),
        ),
      );
} // App
