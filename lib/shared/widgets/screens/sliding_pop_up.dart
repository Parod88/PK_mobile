import 'package:flutter/material.dart';

class SlidingPopUp extends StatelessWidget {
  final Widget child;
  final double initialSize;
  final double minSize;
  final double maxSize;
  const SlidingPopUp({
    super.key,
    required this.child,
    this.initialSize = 0.5,
    this.minSize = 0.5,
    this.maxSize = 0.95,
  });

  void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: initialSize,
          minChildSize: minSize,
          maxChildSize: maxSize,
          expand: false,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              color: Colors.white,
              child: child,
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
