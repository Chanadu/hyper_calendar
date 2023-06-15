import 'package:flutter/material.dart';
import 'package:hyper_calendar/util/create_task/enums/custom_repetition_types.dart';
import 'package:hyper_calendar/util/create_task/enums/repetition_types.dart';
import 'package:provider/provider.dart';

import '../enums/reptition_end_type.dart';
import '../new_task_model.dart';
import 'dialog_repetition_dropdown_menu_button.dart';
import 'number_input.dart';

class CustomRepetitionDialog extends StatefulWidget {
  const CustomRepetitionDialog({
    super.key,
  });

  @override
  State<CustomRepetitionDialog> createState() => _CustomRepetitionDialogState();
}

class _CustomRepetitionDialogState extends State<CustomRepetitionDialog> {
  DateTime selectedDate = DateTime.now();
  List<String> weekDaysOneLetter = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
  List<bool> weekDaysSelected = [];

  @override
  Widget build(BuildContext context) {
    RepetitionEndType endType = Provider.of<NewTaskModel>(context, listen: false).customRepetitionEndType;
    onChange(RepetitionEndType? type) {
      setState(
        () {
          if (type != null) {
            Provider.of<NewTaskModel>(context, listen: false).setCustomRepetitionEndType(type);
          }
        },
      );
    }

    Future<void> selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2020),
        lastDate: DateTime(2100),
      );
      if (picked != null && picked != selectedDate) {
        setState(
          () {
            selectedDate = picked;
            Provider.of<NewTaskModel>(context, listen: false).setCustomRepetitionEndTypeStopDate(picked);
          },
        );
      }
    }

    return SimpleDialog(
      title: const Text("Custom Repetition Selector"),
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text("Repeat every "),
                NumberInput(
                  textStyle: Theme.of(context).textTheme.bodyMedium!,
                  update: (int count) {
                    Provider.of<NewTaskModel>(context, listen: false).setCustomRepetitionDuration(count);
                  },
                ),
                const DialogRepetitionDrowndownMenuButton(),
              ],
            ),
            const SizedBox(height: 16),
            Provider.of<NewTaskModel>(context, listen: true).customRepetitionType == CustomRepetitionTypes.weeks
                ? Row(
                    children: [
                      for (int i = 0; i < 7; i++)
                        Row(
                          children: [
                            Column(
                              children: [
                                Text(weekDaysOneLetter[i]),
                                Checkbox(
                                  fillColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary),
                                  value: Provider.of<NewTaskModel>(context, listen: false).customRepetitionDayList.contains(Days.values[i]),
                                  onChanged: (_) {
                                    setState(
                                      () {
                                        Provider.of<NewTaskModel>(context, listen: false).customRepetitionDayList.contains(Days.values[i])
                                            ? Provider.of<NewTaskModel>(context, listen: false).removeDayToCustomRepetitionDayList(Days.values[i])
                                            : Provider.of<NewTaskModel>(context, listen: false).addDayToCustomRepetitionDayList(Days.values[i]);
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(width: 16),
                          ],
                        ),
                    ],
                  )
                : const SizedBox.shrink(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                const Text("Ends"),
                ListTile(
                  title: Row(
                    children: [
                      Text(
                        "Never",
                        style: Theme.of(context).textTheme.bodyMedium,
                      )
                    ],
                  ),
                  leading: Radio<RepetitionEndType>(
                    value: RepetitionEndType.never,
                    groupValue: endType,
                    onChanged: onChange,
                  ),
                ),
                const SizedBox(height: 8),
                ListTile(
                  title: Row(
                    children: [
                      Text(
                        "On  ",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      ElevatedButton(
                        onPressed: () => selectDate(context),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(color: Theme.of(context).colorScheme.primary),
                          ),
                          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                        ),
                        child: Text(
                          "${selectedDate.month}-${selectedDate.day}-${selectedDate.year}",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                  leading: Radio<RepetitionEndType>(
                    value: RepetitionEndType.on,
                    groupValue: endType,
                    onChanged: onChange,
                  ),
                ),
                const SizedBox(height: 8),
                ListTile(
                  title: Row(
                    children: [
                      Text(
                        "After",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      NumberInput(
                        textStyle: Theme.of(context).textTheme.bodyMedium!,
                        update: (int count) {
                          Provider.of<NewTaskModel>(context, listen: false).setCustomRepetitionEndTypeOccurences(count);
                        },
                      ),
                      Text(
                        "occurences",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  leading: Radio<RepetitionEndType>(
                    value: RepetitionEndType.after,
                    groupValue: endType,
                    onChanged: onChange,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Done",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      onPressed: () {
                        if (Provider.of<NewTaskModel>(context, listen: false).isOneDayTask &&
                            Provider.of<NewTaskModel>(context, listen: false).customRepetitionDayList.isEmpty &&
                            Provider.of<NewTaskModel>(context, listen: false).customRepetitionType == CustomRepetitionTypes.weeks) {
                          Provider.of<NewTaskModel>(context, listen: false).setCustomRepetitionDayList([Days.values[Provider.of<NewTaskModel>(context, listen: false).startDate.weekday]]);
                        }
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
