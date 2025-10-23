// Unique crash marker to locate the exact stack in logcat and verify mapping.
// Keep the line number stable so you can verify symbolized line mapping precisely.
void callBAndThrow() {
  // Attach a stack explicitly so it shows up in release logs.
  Error.throwWithStackTrace(
    StateError('CRASH_MARKER_175126 from b.dart line 6'),
    StackTrace.current,
  );
}

