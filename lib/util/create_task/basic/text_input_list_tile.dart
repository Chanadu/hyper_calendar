import 'package:flutter/material.dart';

class TextInputListTile extends StatefulWidget {
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
  State<TextInputListTile> createState() => _TextInputListTileState();
}

class _TextInputListTileState extends State<TextInputListTile> {
  String text = '';

  @override
  Widget build(BuildContext context) {
    widget.controller.text = text;
    return Container(
      margin: const EdgeInsets.only(top: 15.0),
      child: TextField(
        onChanged: (value) {
          text = widget.controller.text;
        },
        controller: widget.controller,
        style: Theme.of(context).textTheme.bodyMedium,
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          hintText: widget.hint,
          labelText: widget.title,
          icon: widget.icon,
        ),
        maxLines: widget.maxLines,
        minLines: 1,
        maxLength: widget.maxLength,
        obscuringCharacter: '*',
        obscureText: widget.isPassword ?? false,
        enableSuggestions: widget.isPassword == null ? true : !widget.isPassword!,
        autocorrect: widget.isPassword == null
            ? widget.isUsername == null
                ? true
                : !widget.isUsername!
            : !widget.isPassword!,
      ),
    );
  }
}
