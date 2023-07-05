import 'package:flutter/material.dart';

class TextInputListTile extends StatelessWidget {
  const TextInputListTile({
    super.key,
    required this.title,
    required this.hint,
    required this.controller,
    required this.maxLines,
    this.maxLength,
    this.isPassword,
    this.isUsername,
    this.icon,
  });

  final TextEditingController controller;
  final String title;
  final String hint;
  final int maxLines;
  final int? maxLength;
  final bool? isPassword;
  final bool? isUsername;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15.0),
      child: TextField(
        controller: controller,
        style: Theme.of(context).textTheme.bodyMedium,
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          hintText: hint,
          labelText: title,
          icon: icon,
        ),
        maxLines: maxLines,
        minLines: 1,
        maxLength: maxLength,
        obscuringCharacter: '*',
        obscureText: isPassword ?? false,
        enableSuggestions: isPassword == null ? true : !isPassword!,
        autocorrect: isPassword == null
            ? isUsername == null
                ? true
                : !isUsername!
            : !isPassword!,
      ),
    );
  }
}
