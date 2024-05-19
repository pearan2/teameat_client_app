import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';

class TELoading extends StatelessWidget {
  final Color? color;
  final double? size;

  const TELoading({super.key, this.color, this.size});

  @override
  Widget build(BuildContext context) {
    return LoadingAnimationWidget.waveDots(
      color: color ?? DS.getColor().primary500,
      size: size ?? DS.getSpace().base,
    );
  }
}
