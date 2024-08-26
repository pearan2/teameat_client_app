import 'package:flutter/material.dart';

class TEGradientContainer extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final double height;
  final AlignmentGeometry? alignment;

  const TEGradientContainer({
    super.key,
    required this.child,
    required this.height,
    this.borderRadius = 0.0,
    this.alignment = Alignment.centerLeft,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      alignment: alignment,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        gradient: const LinearGradient(
          begin: Alignment(0, -1),
          end: Alignment(0, 1),
          colors: [
            Color.fromRGBO(0, 0, 0, 0.4),
            Color.fromRGBO(0, 0, 0, 0.0),
          ],
        ),
      ),
      child: child,
    );
  }
}
