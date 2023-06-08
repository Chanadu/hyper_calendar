import 'package:flutter/material.dart';

import 'reminder_dropdown_menu.dart';

class ReminderTile extends StatelessWidget {
  const ReminderTile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        ReminderDropdownMenu(
          startingText: "First Reminder at  ",
          number: 1,
        ),
        SizedBox(height: 16),
        ReminderDropdownMenu(
          startingText: "Second Reminder at  ",
          number: 2,
        ),
      ],
    );
  }
}
