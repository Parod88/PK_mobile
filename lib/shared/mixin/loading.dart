import 'package:flutter/material.dart';

mixin LoadingOverlay {
  OverlayEntry? overlay;

  void showSpinner(BuildContext context) {
    if (overlay != null) {
      return;
    }

    overlay = OverlayEntry(
      // replace with your own layout
      builder: (context) => const ColoredBox(
        color: Color(0x80000000),
        child: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.white),
          ),
        ),
      ),
    );
    Overlay.of(context).insert(overlay!);
  }

  void hideSpinner() {
    if (overlay != null) {
      overlay!.remove();
      overlay = null;
    }
  }
}
