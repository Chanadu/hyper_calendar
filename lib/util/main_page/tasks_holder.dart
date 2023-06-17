import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../mongo_db.dart';
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
    print("Find Tasks run");

    for (int i = 0; i < holder.length; i++) {
      if (widget.selectedDate!.compareTo(DateTime(holder[i]["start"]["date"]["year"], holder[i]["start"]["date"]["month"], holder[i]["start"]["date"]["day"])) <= 0 &&
          widget.selectedDate!.compareTo(DateTime(holder[i]["end"]["date"]["year"], holder[i]["end"]["date"]["month"], holder[i]["end"]["date"]["day"])) >= 0) {
        currentTasks.add(holder[i]);
      }
    }

    if (widget.selectedDate != null) {
      tasksLength = currentTasks.length;
    }

    const DeepCollectionEquality().equals(currentTasks, tasks)
        ? print("Equal")
        : setState(() {
            print("$currentTasks\n$tasks");
            tasks = currentTasks;
          });
  }

  // holder = await MongoDB.coll.find({
  //   "start.date.year": widget.selectedDate!.year,
  //   "start.date.month": widget.selectedDate!.month,
  //   "start.date.day": widget.selectedDate!.day,
  // }).toList();

  @override
  Widget build(BuildContext context) {
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
                widget.selectedDate == null ? "Pick a Date to view the Tasks" : "Tasks on ${DateFormat('EEEE MMM d, yyyy').format(widget.selectedDate!)}:",
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          for (int i = 0; i < tasksLength; i++) Task(eventName: tasks![i]["eventName"]),
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
