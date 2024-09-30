import 'package:flutter/material.dart';

class TEGradientContainer extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final double height;
  final AlignmentGeometry? alignment;
  final AlignmentGeometry gradientStartPoint;
  final AlignmentGeometry gradientEndPoint;

  const TEGradientContainer({
    super.key,
    required this.child,
    required this.height,
    this.borderRadius = 0.0,
    this.alignment = Alignment.centerLeft,
    this.gradientStartPoint = const Alignment(0, -1),
    this.gradientEndPoint = const Alignment(0, 1),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      alignment: alignment,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        gradient: LinearGradient(
          begin: gradientStartPoint,
          end: gradientEndPoint,
          colors: const [
            Color.fromRGBO(0, 0, 0, 0.4),
            Color.fromRGBO(0, 0, 0, 0.0),
          ],
        ),
      ),
      child: child,
    );
  }
}
