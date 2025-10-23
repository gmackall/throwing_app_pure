# throwing_app_pure


1. Run `./build_and_run.sh`
2. Clear the adb logs and then capture them after pressing the crash button: `adb logcat -d > /tmp/dart_crash_raw.txt`
3. Run flutter symbolize: `flutter symbolize -i /tmp/dart_crash_raw.txt -d build/app/outputs/symbols/app.android-arm64.symbols > /tmp/dart_crash_symbolized_aab8.txt`
4. Inspect the logs

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
