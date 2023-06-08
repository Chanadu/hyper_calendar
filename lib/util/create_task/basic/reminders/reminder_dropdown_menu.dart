import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../enums/reminder_types.dart';
import '../../new_task_model.dart';

class ReminderDropdownMenu extends StatefulWidget {
  const ReminderDropdownMenu({
    super.key,
    required this.startingText,
    required this.number,
  });

  final String startingText;
  final int number;

  @override
  State<ReminderDropdownMenu> createState() => _ReminderDropdownMenuState();
}

class _ReminderDropdownMenuState extends State<ReminderDropdownMenu> {
  ReminderTypes dropdownValue = ReminderTypes.noReminder;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(widget.startingText),
        DropdownButton(
          value: dropdownValue,
          icon: Icon(Icons.arrow_downward_rounded, color: Theme.of(context).colorScheme.primary),
          elevation: 16,
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          items: ReminderTypes.values.map((ReminderTypes value) {
            return DropdownMenuItem<ReminderTypes>(
              value: value,
              child: Text(
                reminderTypesToString(value),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            );
          }).toList(),
          onChanged: (value) {
            setState(
              () {
                if (value != null) {
                  dropdownValue = value;
                  widget.number == 1
                      ? Provider.of<NewTaskModel>(context, listen: false).setFirstReminder(value)
                      : Provider.of<NewTaskModel>(context, listen: false).setSecondReminder(value);
                }
              },
            );
          },
        ),
        const Text("."),
      ],
    );
  }
}
