import 'b.dart';

// Entry point used by main.dart (post-frame and button).
void entryPointA() {
  // Add an intermediate frame to diversify the stack.
  intermediateLayer();
}

void intermediateLayer() {
  callBAndThrow();
}
