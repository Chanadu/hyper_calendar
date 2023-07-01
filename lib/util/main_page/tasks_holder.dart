import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hyper_calendar/util/enums/repetition_types.dart';
import 'package:hyper_calendar/util/enums/reptition_end_type.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import '../../mongo_db.dart';
import '../enums/custom_repetition_types.dart';
import '../holder.dart';
import 'task.dart';

class TasksHolder extends StatefulWidget {
  const TasksHolder({
    super.key,
    required this.selectedDate,
  });

  final DateTime selectedDate;

  @override
  State<TasksHolder> createState() => _TasksHolderState();
}

class _TasksHolderState extends State<TasksHolder> {
  List<Map<String, dynamic>>? tasks;
  int tasksLength = 0;

  void findTasks(DateTime date) async {
    List<Map<String, dynamic>> currentTasks = [];
    List<Map<String, dynamic>>? holder;
    do {
      try {
        holder = await MongoDB.coll!.find().toList();
      } catch (_) {
        await Future.delayed(const Duration(milliseconds: 10));
      }
    } while (holder == null);

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

      if (date.compareTo(startDate) >= 0 && date.compareTo(endDate) <= 0) {
        currentTasks.add(task);
        continue;
      }
      if (date.compareTo(startDate) < 0) {
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
          if (date.weekday == startDate.weekday) {
            currentTasks.add(task);
          }
          break;
        case RepetitionTypes.monthly:
          if (date.day == startDate.day) {
            currentTasks.add(task);
          }
          break;
        case RepetitionTypes.yearly:
          if (DateTime(1, date.month, date.day).isAtSameMomentAs(DateTime(1, startDate.month, startDate.day))) {
            currentTasks.add(task);
          }
          break;
        case RepetitionTypes.custom:
          CustomRepetitionTypes customRepetitionType = CustomRepetitionTypes.values.byName((task['repetition']['custom']['type'] as String).split('.')[1]);
          int duration = task['repetition']['custom']['duration'] as int;

          RepetitionEndType endType = RepetitionEndType.values.byName((task['repetition']['custom']['end']['type'] as String).split('.')[1]);

          switch (endType) {
            case RepetitionEndType.never:
              break;
            case RepetitionEndType.on:
              DateTime endingDate = DateTime(
                task['repetition']['custom']['end']['date']['year'] as int,
                task['repetition']['custom']['end']['date']['month'] as int,
                task['repetition']['custom']['end']['date']['day'] as int,
              );
              if (date.isAfter(endingDate)) {
                continue;
              }
              break;
            case RepetitionEndType.after:
              int endOccurences = task['repetition']['custom']['end']['occurences'] as int;
              switch (customRepetitionType) {
                case CustomRepetitionTypes.days:
                  if (((Jiffy.parseFromDateTime(date).dayOfYear - Jiffy.parseFromDateTime(startDate).dayOfYear) / duration) + 1 > endOccurences) {
                    continue;
                  }
                  break;
                case CustomRepetitionTypes.weeks:
                  //JUST THIS ONE LEFT
                  List<Days> days = [];
                  task['repetition']['custom']['dayList']['sunday'] as bool ? days.add(Days.sunday) : null;
                  task['repetition']['custom']['dayList']['monday'] as bool ? days.add(Days.monday) : null;
                  task['repetition']['custom']['dayList']['tuesday'] as bool ? days.add(Days.tuesday) : null;
                  task['repetition']['custom']['dayList']['wednesday'] as bool ? days.add(Days.wednesday) : null;
                  task['repetition']['custom']['dayList']['thursday'] as bool ? days.add(Days.thursday) : null;
                  task['repetition']['custom']['dayList']['friday'] as bool ? days.add(Days.friday) : null;
                  task['repetition']['custom']['dayList']['saturday'] as bool ? days.add(Days.saturday) : null;

                  if (((Jiffy.parseFromDateTime(date).weekOfYear - Jiffy.parseFromDateTime(startDate).weekOfYear) / duration) + 1 > endOccurences) {
                    continue;
                  }
                  break;
                case CustomRepetitionTypes.months:
                  if (((Jiffy.parseFromDateTime(date).month - Jiffy.parseFromDateTime(startDate).month) / duration) + 1 > endOccurences) {
                    continue;
                  }
                  break;
                case CustomRepetitionTypes.years:
                  if (((Jiffy.parseFromDateTime(date).year - Jiffy.parseFromDateTime(startDate).year) / duration + 1) > endOccurences) {
                    continue;
                  }
                  break;
              }
          }

          switch (customRepetitionType) {
            case CustomRepetitionTypes.days:
              if ((Jiffy.parseFromDateTime(date).dayOfYear - Jiffy.parseFromDateTime(startDate).dayOfYear) % duration == 0) {
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

              if (days.contains(Days.values[date.weekday % 7]) && (Jiffy.parseFromDateTime(date).weekOfYear - Jiffy.parseFromDateTime(startDate).weekOfYear) % duration == 0) {
                currentTasks.add(task);
              }
              break;
            case CustomRepetitionTypes.months:
              if ((Jiffy.parseFromDateTime(date).month - Jiffy.parseFromDateTime(startDate).month) % duration == 0) {
                currentTasks.add(task);
              }
              break;
            case CustomRepetitionTypes.years:
              if ((Jiffy.parseFromDateTime(date).year - Jiffy.parseFromDateTime(startDate).year) % duration == 0) {
                currentTasks.add(task);
              }
              break;
          }
          break;
      }
    }

    tasksLength = currentTasks.length;

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
    findTasks(widget.selectedDate);
    return Holder(
      width: MediaQuery.of(context).size.width * 2.0 / 3.0,
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 2.0 / 3.0,
            child: Wrap(
              alignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  "Tasks on ${DateFormat('EEEE MMM d, yyyy').format(widget.selectedDate)}:",
                  style: TextStyle(
                    fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          for (int i = 0; i < tasksLength; i++)
            Task(
              date: widget.selectedDate,
              task: tasks![i],
            ),
          tasksLength == 0 ? Task(date: widget.selectedDate) : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
