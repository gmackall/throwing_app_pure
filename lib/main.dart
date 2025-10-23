import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';

import 'src/a.dart';

/// Crashes only when you press the button.
const bool hardCrash = true;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Do NOT override FlutterError.onError; let async errors go via onError below.

  // Print uncaught async errors; return false so the engine treats them as unhandled.
  PlatformDispatcher.instance.onError = (error, stack) {
    // Print a clear header plus the stack (so it's in logcat for symbolization).
    // You can also use debugPrintStack if you prefer.
    // Use stdout so it shows as "I flutter" lines.
    // The attached stack (from throwWithStackTrace) will include frames (#0, #1, ...).
    // Note: You can omit this print if you prefer relying only on engine's default.
    // But printing makes it deterministic across versions.
    // ignore: avoid_print
    print('UNHANDLED (will crash): $error');
    // ignore: avoid_print
    print(stack);

    if (hardCrash) {
      // Give logs a moment to flush, then terminate the process.
      Future<void>.delayed(const Duration(milliseconds: 10), () => exit(1));
    }
    // Return false => not handled => still considered unhandled (crash).
    return false;
  };

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  void _crashAsyncUncaught() {
    // Schedule outside the current sync frame so it routes to onError.
    Future<void>.microtask(() {
      entryPointA(); // Will throw in b.dart
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Throwing App (Pure)',
      home: Scaffold(
        appBar: AppBar(title: const Text('Throwing App (Pure)')),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Press the button to throw an uncaught Dart exception (multi-file chain).',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _crashAsyncUncaught,
                child: const Text('Crash now (uncaught throw)'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
