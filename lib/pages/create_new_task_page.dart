import 'package:flutter/material.dart';
import 'package:hyper_calendar/mongo_db.dart';
import 'package:hyper_calendar/util/enums/custom_repetition_types.dart';
import 'package:hyper_calendar/util/enums/reminder_types.dart';
import 'package:hyper_calendar/util/enums/repetition_types.dart';
import 'package:hyper_calendar/util/enums/reptition_end_type.dart';
import 'package:hyper_calendar/util/main_page/time_of_day_compare_to.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../util/create_task/basic/basic_information_tile.dart';
import '../util/create_task/date/date_input_list_tile.dart';
import '../util/new_task_model.dart';
import '../util/holder.dart';

class CreateNewTaskPage extends StatelessWidget {
  CreateNewTaskPage({
    super.key,
    this.task,
  });

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final Map<String, dynamic>? task;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'New Task',
        ),
        leading: BackButton(
          onPressed: () {
            Provider.of<NewTaskModel>(context, listen: false).setStartDate(DateTime.now());
            Provider.of<NewTaskModel>(context, listen: false).setEndDate(DateTime.now());
            Provider.of<NewTaskModel>(context, listen: false).setStartTimeOfDay(TimeOfDay.now());
            Provider.of<NewTaskModel>(context, listen: false).setEndTimeOfDay(TimeOfDay.now());
            Provider.of<NewTaskModel>(context, listen: false).setColor(Theme.of(context).colorScheme.primary);
            Provider.of<NewTaskModel>(context, listen: false).setDescription('');
            Provider.of<NewTaskModel>(context, listen: false).setEventName('');
            Provider.of<NewTaskModel>(context, listen: false).setFirstReminder(ReminderTypes.noReminder);
            Provider.of<NewTaskModel>(context, listen: false).setSecondReminder(ReminderTypes.noReminder);
            Provider.of<NewTaskModel>(context, listen: false).setRepetitionState(RepetitionTypes.doesNotRepeat);
            Provider.of<NewTaskModel>(context, listen: false).setCustomRepetitionType(CustomRepetitionTypes.days);
            Provider.of<NewTaskModel>(context, listen: false).setCustomRepetitionEndType(RepetitionEndType.never);
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: [
              Holder(
                title: 'Basic Information',
                child: BasicInformationTile(
                  nameController: nameController,
                  descriptionController: descriptionController,
                ),
              ),
              const Holder(
                title: 'Timings',
                child: DateInputListTile(),
              ),
              Consumer<NewTaskModel>(builder: (context, value, child) {
                return value.startTimeOfDay.compareTo(value.endTimeOfDay) >= 0 && value.startDate.compareTo(value.endDate) >= 0
                    ? const Text('Make sure the start date/time is before the end date/time.')
                    : const SizedBox.shrink();
              }),
              const SizedBox(height: 8),
              Consumer<NewTaskModel>(
                builder: (context, value, child) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.primary),
                    onPressed: value.startTimeOfDay.compareTo(value.endTimeOfDay) >= 0 && value.startDate.compareTo(value.endDate) >= 0
                        ? null
                        : () async {
                            value.setEventName(nameController.text);
                            value.setDescription(descriptionController.text);
                            String response = await MongoDB.insertEvent(
                              MongoDbEventModel(
                                userId: usernameId!,
                                eventName: value.eventName,
                                description: value.description,
                                color: value.color,
                                firstReminder: value.firstReminder,
                                secondReminder: value.secondReminder,
                                startDate: value.startDate,
                                startTime: value.startTimeOfDay,
                                endDate: value.endDate,
                                endTime: value.endTimeOfDay,
                                repetitionState: value.repetitionState,
                                customRepetitionType: value.customRepetitionType,
                                customRepetitionDayList: value.customRepetitionDayList,
                                customRepetitionEndType: value.customRepetitionEndType,
                                customRepetitionDuration: value.customRepetitionDuration,
                                customRepetitionEndTypeOccurences: value.customRepetitionEndTypeOccurences,
                                customRepetitionEndTypeStopDate: value.customRepetitionEndTypeStopDate,
                              ),
                            );
                            if (context.mounted) {
                              value.setStartDate(DateTime.now());
                              value.setEndDate(DateTime.now());
                              value.setStartTimeOfDay(TimeOfDay.now());
                              value.setEndTimeOfDay(TimeOfDay.now());
                              value.setColor(Theme.of(context).colorScheme.primary);
                              value.setDescription('');
                              value.setEventName('');
                              value.setFirstReminder(ReminderTypes.noReminder);
                              value.setSecondReminder(ReminderTypes.noReminder);
                              value.setRepetitionState(RepetitionTypes.doesNotRepeat);
                              value.setCustomRepetitionType(CustomRepetitionTypes.days);
                              value.setCustomRepetitionEndType(RepetitionEndType.never);
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Center(
                                  child: Text(
                                    response,
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
                          },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Create',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
