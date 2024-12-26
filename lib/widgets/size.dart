import 'package:flutter/material.dart';

class SizedBoxHeight extends StatelessWidget {
  const SizedBoxHeight(this.height, {super.key});
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}

class SizedBoxWidth extends StatelessWidget {
  const SizedBoxWidth(this.width, {super.key});
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
    );
  }
}
