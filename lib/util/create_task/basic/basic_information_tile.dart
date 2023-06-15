import 'package:flutter/material.dart';

import 'reminders/reminder_tile.dart';
import 'color_selector.dart';
import 'text_input_list_tile.dart';

class BasicInformationTile extends StatelessWidget {
  const BasicInformationTile({
    super.key,
    required this.nameController,
    required this.descriptionController,
  });

  final TextEditingController nameController;
  final TextEditingController descriptionController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextInputListTile(
          title: "Event Name",
          hint: "",
          controller: nameController,
          maxLines: 1,
        ),
        const SizedBox(height: 10),
        TextInputListTile(
          title: "Description",
          hint: "",
          controller: descriptionController,
          maxLines: 3,
        ),
        const SizedBox(height: 30),
        const ColorSelector(),
        const SizedBox(height: 30),
        const ReminderTile(),
      ],
    );
  }
}
