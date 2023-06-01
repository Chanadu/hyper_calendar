import 'package:flutter/material.dart';

class LeftDivider extends StatelessWidget {
  const LeftDivider({
    super.key,
    required this.objectDecoration,
  });

  final Decoration objectDecoration;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(left: 128.0),
        height: 5,
        decoration: objectDecoration,
      ),
    );
  }
}

class RightDivider extends StatelessWidget {
  const RightDivider({
    super.key,
    required this.objectDecoration,
  });

  final Decoration objectDecoration;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 5,
        decoration: objectDecoration,
        margin: const EdgeInsets.only(right: 128.0),
      ),
    );
  }
}

class HeightSpacer extends StatelessWidget {
  const HeightSpacer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 15,
    );
  }
}
