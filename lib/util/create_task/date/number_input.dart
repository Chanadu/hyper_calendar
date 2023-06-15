import 'package:flutter/material.dart';

import 'small_icon_button.dart';

class NumberInput extends StatefulWidget {
  const NumberInput({
    super.key,
    required this.textStyle,
    required this.update,
  });

  final TextStyle textStyle;
  final Function update;

  @override
  State<NumberInput> createState() => _NumberInputState();
}

class _NumberInputState extends State<NumberInput> {
  int count = 1;

  void increment() {
    setState(() {
      count++;
      widget.update(count);
    });
  }

  void decrement() {
    if (count <= 1) return;
    setState(() {
      count--;
      widget.update(count);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SmallIconButton(
          onPressed: increment,
          icon: Icons.arrow_upward_rounded,
        ),
        Text(
          "$count",
          style: widget.textStyle,
        ),
        SmallIconButton(
          onPressed: decrement,
          icon: Icons.arrow_downward_rounded,
        ),
      ],
    );
  }
}
