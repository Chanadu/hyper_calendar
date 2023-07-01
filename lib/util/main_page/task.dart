import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../create_task/date/small_icon_button.dart';
import '../enums/reminder_types.dart';

class Task extends StatelessWidget {
  const Task({
    super.key,
    required this.date,
    this.task,
  });

  final DateTime date;
  final Map<String, dynamic>? task;

  @override
  Widget build(BuildContext context) {
    Widget taskInnerWidget;
    Color containerBorderColor = Theme.of(context).colorScheme.primary;
    if (task == null) {
      taskInnerWidget = Text(
        '    • There are no event on ${DateFormat('MMM d').format(date)}.',
        style: Theme.of(context).textTheme.bodyMedium,
      );
    } else {
      String eventName = task!['eventName'] as String;
      String description = task!['description'] as String;
      TimeOfDay startTime = TimeOfDay(hour: task!['start']['time']['hour'] as int, minute: task!['start']['time']['minute'] as int);
      TimeOfDay endTime = TimeOfDay(hour: task!['end']['time']['hour'] as int, minute: task!['end']['time']['minute'] as int);
      ReminderTypes? reminderOne = ReminderTypes.values.byName(task!['reminders']['first'].split('.')[1]);
      ReminderTypes? reminderTwo = ReminderTypes.values.byName(task!['reminders']['second'].split('.')[1]);

      String reminderText = reminderTypesToString(reminderOne).toLowerCase() == 'no reminder' && reminderTypesToString(reminderTwo).toLowerCase() == 'no reminder'
          ? 'No Reminders'
          : reminderTypesToString(reminderOne).toLowerCase() == 'no reminder'
              ? 'Reminder at ${reminderTypesToString(reminderTwo).toLowerCase()}'
              : reminderTypesToString(reminderTwo).toLowerCase() == 'no reminder'
                  ? 'Reminder at ${reminderTypesToString(reminderOne).toLowerCase()}'
                  : 'Reminders at ${reminderTypesToString(reminderOne).toLowerCase()} and ${reminderTypesToString(reminderTwo).toLowerCase()}';

      containerBorderColor = Color((task!['color'] as Int64).toInt());
      taskInnerWidget = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            alignment: WrapAlignment.start,
            children: [
              Text(
                '• $eventName',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SmallIconButton(onPressed: () {}, icon: Icons.edit_rounded),
              SmallIconButton(onPressed: () {}, icon: Icons.delete_rounded),
            ],
          ),
          const SizedBox(height: 12),
          description.isEmpty
              ? const SizedBox.shrink()
              : Text(
                  '     $description',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
          const SizedBox(height: 4),
          Text(
            '     ${startTime.format(context)} - ${endTime.format(context)}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 4),
          Text(
            '     $reminderText',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      );
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: containerBorderColor),
      ),
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(24),
      child: taskInnerWidget,
    );
  }
}
