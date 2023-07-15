import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:hyper_calendar/util/mongo_db.dart';
import 'package:intl/intl.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo_db;

import '../../create_task/date/small_icon_button.dart';
import '../../enums/reminder_types.dart';
import '../../enums/repetition_types.dart';

class Task extends StatefulWidget {
  const Task({
    super.key,
    required this.date,
    this.task,
    this.loading,
  });

  final DateTime date;
  final Map<String, dynamic>? task;
  final bool? loading;

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  @override
  Widget build(BuildContext context) {
    Future<void> showDeleteDialog() {
      return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          bool deleteAllOccurences = true;
          return StatefulBuilder(
            builder: (BuildContext ontext, void Function(void Function()) setState) {
              return AlertDialog(
                title: const Text('Delete Task'),
                content: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        'THIS IS NOT REVERTABLE!',
                        style: TextStyle(
                          fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                      const SizedBox(height: 16),
                      RepetitionTypes.values.byName((widget.task!['repetition']['state'] as String).split('.')[1]) == RepetitionTypes.doesNotRepeat
                          ? const SizedBox.shrink()
                          : Row(
                              children: [
                                Text(
                                  'Apply to all repetitions of the task: ',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                Switch.adaptive(
                                  value: deleteAllOccurences,
                                  onChanged: (bool value) {
                                    setState(
                                      () {
                                        deleteAllOccurences = value;
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).colorScheme.surface,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: BorderSide(color: Theme.of(context).colorScheme.primary),
                              ),
                              padding: const EdgeInsets.all(16.0),
                            ),
                            child: Text(
                              'Cancel',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: () async {
                              if (deleteAllOccurences) {
                                await (await MongoDB.eventsColl)!.remove({'_id': widget.task!['_id'] as mongo_db.ObjectId});
                                await (await MongoDB.singleDeleteOccurencesColl)!.remove({'eventId': widget.task!['_id'] as mongo_db.ObjectId});

                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Center(
                                      child: Text(
                                        "Removed ${widget.task!['eventName']}.",
                                        style: TextStyle(
                                          color: Theme.of(context).colorScheme.onPrimary,
                                          fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                                  ));
                                  Navigator.pop(context);
                                }
                              } else {
                                String result = await MongoDB.insertSingleDeleteOccurences(
                                    MongoDbSingleDeleteOccurencesModel(
                                      eventId: widget.task!['_id'],
                                      date: widget.date,
                                    ),
                                    widget.task!['eventName']);
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Center(
                                      child: Text(
                                        result,
                                        style: TextStyle(
                                          color: Theme.of(context).colorScheme.onPrimary,
                                          fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                                  ));
                                  Navigator.pop(context);
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).colorScheme.surface,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: BorderSide(color: Theme.of(context).colorScheme.error),
                              ),
                              padding: const EdgeInsets.all(16.0),
                            ),
                            child: Text(
                              'Delete',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ).then(
        (_) {
          setState(
            () {},
          );
        },
      );
    }

    Widget taskInnerWidget;
    Color containerBorderColor = Theme.of(context).colorScheme.primary;

    if (widget.loading != null && widget.loading!) {
      taskInnerWidget = Text(
        'Loading Tasks',
        style: Theme.of(context).textTheme.bodyMedium,
      );
    } else if (widget.task == null) {
      taskInnerWidget = Text(
        '    • There are no event on ${DateFormat('MMM d').format(widget.date)}.',
        style: Theme.of(context).textTheme.bodyMedium,
      );
    } else {
      String eventName = widget.task!['eventName'] as String;
      String description = widget.task!['description'] as String;
      TimeOfDay startTime = TimeOfDay(hour: widget.task!['start']['time']['hour'] as int, minute: widget.task!['start']['time']['minute'] as int);
      TimeOfDay endTime = TimeOfDay(hour: widget.task!['end']['time']['hour'] as int, minute: widget.task!['end']['time']['minute'] as int);
      ReminderTypes? reminderOne = ReminderTypes.values.byName(widget.task!['reminders']['first'].split('.')[1]);
      ReminderTypes? reminderTwo = ReminderTypes.values.byName(widget.task!['reminders']['second'].split('.')[1]);

      String reminderText = reminderTypesToString(reminderOne).toLowerCase() == 'no reminder' && reminderTypesToString(reminderTwo).toLowerCase() == 'no reminder'
          ? 'No Reminders'
          : reminderTypesToString(reminderOne).toLowerCase() == 'no reminder'
              ? 'Reminder at ${reminderTypesToString(reminderTwo).toLowerCase()}'
              : reminderTypesToString(reminderTwo).toLowerCase() == 'no reminder'
                  ? 'Reminder at ${reminderTypesToString(reminderOne).toLowerCase()}'
                  : 'Reminders at ${reminderTypesToString(reminderOne).toLowerCase()} and ${reminderTypesToString(reminderTwo).toLowerCase()}';

      containerBorderColor = Color((widget.task!['color'] as Int64).toInt());
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
              const SizedBox(width: 16),
              SmallIconButton(
                onPressed: () {},
                icon: Icons.edit_rounded,
              ),
              SmallIconButton(
                onPressed: () => showDeleteDialog(),
                icon: Icons.delete_rounded,
              ),
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
