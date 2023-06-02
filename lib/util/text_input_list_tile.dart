import 'package:flutter/material.dart';

class TextInputListTile extends StatelessWidget {
  const TextInputListTile({
    super.key,
    required this.title,
    required this.hint,
    required this.controller,
    required this.maxLines,
  });

  final TextEditingController controller;
  final String title;
  final String hint;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15.0),
      child: TextField(
        controller: controller,
        style: Theme.of(context).textTheme.bodyMedium,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: hint,
          labelText: title,
        ),
        maxLines: maxLines,
        minLines: 1,
      ),
    );
  }
}
//trailing: Container(width: 150, child: TextField()),