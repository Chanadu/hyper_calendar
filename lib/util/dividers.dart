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

class FullDivider extends StatelessWidget {
  const FullDivider({
    super.key,
    required this.context,
    required this.height,
    required this.width,
  });
  final BuildContext context;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    Decoration objectDecoration = BoxDecoration(
      color: Theme.of(context).colorScheme.primary,
      borderRadius: const BorderRadius.all(Radius.circular(5)),
    );
    return Container(
      height: height,
      width: width,
      decoration: objectDecoration,
    );
  }
}
