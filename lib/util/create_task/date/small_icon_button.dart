import 'package:flutter/material.dart';

class SmallIconButton extends StatelessWidget {
  const SmallIconButton({super.key, required this.onPressed, required this.icon});

  final Function()? onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: const ShapeDecoration(
        color: Colors.transparent,
        shape: CircleBorder(),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: Theme.of(context).colorScheme.primary,
        ),
        splashRadius: 17,
      ),
    );
  }
}
