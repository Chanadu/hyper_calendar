import 'package:flutter/material.dart';
import 'package:hyper_calendar/util/create_task/enums/custom_repetition_types.dart';
import 'package:hyper_calendar/util/create_task/enums/reminder_types.dart';
import 'package:hyper_calendar/util/create_task/enums/repetition_types.dart';
import 'package:hyper_calendar/util/create_task/enums/reptition_end_type.dart';
import 'package:provider/provider.dart';

import '../util/create_task/basic/basic_information_tile.dart';
import '../util/create_task/date/date_input_list_tile.dart';
import '../util/create_task/new_task_model.dart';
import '../util/holder.dart';

class CreateNewTask extends StatelessWidget {
  const CreateNewTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "New Task",
        ),
        leading: BackButton(
          onPressed: () {
            Provider.of<NewTaskModel>(context, listen: false).setStartDate(DateTime.now());
            Provider.of<NewTaskModel>(context, listen: false).setEndDate(DateTime.now());
            Provider.of<NewTaskModel>(context, listen: false).setStartTimeOfDay(TimeOfDay.now());
            Provider.of<NewTaskModel>(context, listen: false).setEndTimeOfDay(TimeOfDay.now());
            Provider.of<NewTaskModel>(context, listen: false).setColor(Theme.of(context).colorScheme.primary);
            Provider.of<NewTaskModel>(context, listen: false).setDescription("");
            Provider.of<NewTaskModel>(context, listen: false).setEventName("");
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
              const Holder(
                title: "Basic Information",
                child: BasicInformationTile(),
              ),
              const Holder(
                title: "Timings",
                child: DateInputListTile(),
              ),
              Provider.of<NewTaskModel>(context, listen: true).startDate.isAfter(Provider.of<NewTaskModel>(context, listen: true).endDate) ||
                      Provider.of<NewTaskModel>(context, listen: true).endDate.isAtSameMomentAs(Provider.of<NewTaskModel>(context, listen: true).startDate)
                  ? const Text("Make sure the end date/time is before the start date/time.")
                  : const SizedBox.shrink(),
              const SizedBox(height: 8),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.primary),
                onPressed: Provider.of<NewTaskModel>(context, listen: true).startDate.isAfter(Provider.of<NewTaskModel>(context, listen: true).endDate) ||
                        Provider.of<NewTaskModel>(context, listen: true).endDate.isAtSameMomentAs(Provider.of<NewTaskModel>(context, listen: true).startDate)
                    ? null
                    : () {
                        Navigator.pop(context);
                      },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Create",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
