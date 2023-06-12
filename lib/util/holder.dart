import 'package:flutter/material.dart';

class Holder extends StatelessWidget {
  const Holder({
    super.key,
    required this.child,
    this.title,
    this.padding,
    this.width,
  });

  final Widget child;
  final String? title;
  final EdgeInsetsGeometry? padding;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: width,
          padding: padding ?? const EdgeInsets.only(bottom: 48, top: 32, left: 32, right: 32),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: Theme.of(context).colorScheme.surface,
          ),
          child: Column(
            children: [
              title != null
                  ? Column(
                      children: [
                        Text(
                          title!,
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                        const SizedBox(height: 32.0),
                      ],
                    )
                  : const SizedBox.shrink(),
              child,
            ],
          ),
        ),
        const SizedBox(height: 32.0),
      ],
    );
  }
}
