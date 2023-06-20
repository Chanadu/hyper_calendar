import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hyper_calendar/util/create_task/enums/repetition_types.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import '../../mongo_db.dart';
import '../create_task/enums/custom_repetition_types.dart';
import '../holder.dart';

class TasksHolder extends StatefulWidget {
  const TasksHolder({
    super.key,
    required this.selectedDate,
  });

  final DateTime? selectedDate;

  @override
  State<TasksHolder> createState() => _TasksHolderState();
}

class _TasksHolderState extends State<TasksHolder> {
  List<Map<String, dynamic>>? tasks;
  int tasksLength = 0;

  void findTasks() async {
    List<Map<String, dynamic>> currentTasks = [];
    List<Map<String, dynamic>> holder = await MongoDB.coll.find().toList();
    for (int i = 0; i < holder.length; i++) {
      Map<String, dynamic> task = holder[i];
      DateTime startDate = DateTime(
        task['start']['date']['year'] as int,
        task['start']['date']['month'] as int,
        task['start']['date']['day'] as int,
      );
      DateTime endDate = DateTime(
        task['end']['date']['year'] as int,
        task['end']['date']['month'] as int,
        task['end']['date']['day'] as int,
      );

      if (widget.selectedDate!.compareTo(startDate) >= 0 && widget.selectedDate!.compareTo(endDate) <= 0) {
        currentTasks.add(task);
        continue;
      }
      if (widget.selectedDate!.compareTo(startDate) < 0) {
        continue;
      }

      RepetitionTypes repetitionType = RepetitionTypes.values.byName((task['repetition']['state'] as String).split('.')[1]);
      switch (repetitionType) {
        case RepetitionTypes.doesNotRepeat:
          break;
        case RepetitionTypes.daily:
          currentTasks.add(task);
          break;
        case RepetitionTypes.weekly:
          if (widget.selectedDate!.weekday == startDate.weekday) {
            currentTasks.add(task);
          }
          break;
        case RepetitionTypes.monthly:
          if (widget.selectedDate!.day == startDate.day) {
            currentTasks.add(task);
          }
          break;
        case RepetitionTypes.yearly:
          if (DateTime(1, widget.selectedDate!.month, widget.selectedDate!.day).compareTo(DateTime(1, startDate.month, startDate.day)) == 0) {
            currentTasks.add(task);
          }
          break;
        case RepetitionTypes.custom:
          CustomRepetitionTypes customRepetitionType = CustomRepetitionTypes.values.byName((task['repetition']['custom']['type'] as String).split('.')[1]);
          int duration = task['repetition']['custom']['duration'] as int;

          switch (customRepetitionType) {
            case CustomRepetitionTypes.days:
              if ((Jiffy.parseFromDateTime(widget.selectedDate!).dayOfYear - Jiffy.parseFromDateTime(startDate).dayOfYear) % duration == 0) {
                currentTasks.add(task);
              }
              break;
            case CustomRepetitionTypes.weeks:
              List<Days> days = [];
              task['repetition']['custom']['dayList']['sunday'] as bool ? days.add(Days.sunday) : null;
              task['repetition']['custom']['dayList']['monday'] as bool ? days.add(Days.monday) : null;
              task['repetition']['custom']['dayList']['tuesday'] as bool ? days.add(Days.tuesday) : null;
              task['repetition']['custom']['dayList']['wednesday'] as bool ? days.add(Days.wednesday) : null;
              task['repetition']['custom']['dayList']['thursday'] as bool ? days.add(Days.thursday) : null;
              task['repetition']['custom']['dayList']['friday'] as bool ? days.add(Days.friday) : null;
              task['repetition']['custom']['dayList']['saturday'] as bool ? days.add(Days.saturday) : null;

              if (days.contains(Days.values[widget.selectedDate!.weekday % 7]) &&
                  (Jiffy.parseFromDateTime(widget.selectedDate!).weekOfYear - Jiffy.parseFromDateTime(startDate).weekOfYear) % duration == 0) {
                currentTasks.add(task);
              }
              break;
            case CustomRepetitionTypes.months:
              if ((Jiffy.parseFromDateTime(widget.selectedDate!).month - Jiffy.parseFromDateTime(startDate).month) % duration == 0) {
                currentTasks.add(task);
              }
              break;
            case CustomRepetitionTypes.years:
              if ((Jiffy.parseFromDateTime(widget.selectedDate!).year - Jiffy.parseFromDateTime(startDate).year) % duration == 0) {
                currentTasks.add(task);
              }
              break;
          }
          break;
      }
    }

    if (widget.selectedDate != null) {
      tasksLength = currentTasks.length;
    }

    const DeepCollectionEquality().equals(currentTasks, tasks)
        ? null
        : setState(
            () {
              tasks = currentTasks;
            },
          );
  }

  @override
  Widget build(BuildContext context) {
    print("rebuild");
    if (widget.selectedDate != null) {
      findTasks();
    }
    return Holder(
      width: MediaQuery.of(context).size.width * 2.0 / 3.0,
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                widget.selectedDate == null ? 'Pick a Date to view the Tasks' : "Tasks on ${DateFormat('EEEE MMM d, yyyy').format(widget.selectedDate!)}:",
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          for (int i = 0; i < tasksLength; i++) Task(eventName: tasks![i]['eventName']),
          widget.selectedDate == null
              ? const SizedBox.shrink()
              : tasksLength == 0
                  ? Task(eventName: "There are no event on ${DateFormat('MMM d').format(widget.selectedDate!)}.")
                  : const SizedBox.shrink(),
        ],
      ),
    );
  }
}

class Task extends StatelessWidget {
  const Task({
    super.key,
    required this.eventName,
  });

  final String eventName;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Theme.of(context).colorScheme.primary),
      ),
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      child: Text(
        '    • $eventName',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}
