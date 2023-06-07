import 'package:flutter/material.dart';
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
  RepetitionEndType _endType = RepetitionEndType.never;

  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    onChange(RepetitionEndType? type) {
      setState(
        () {
          if (type != null) {
            Provider.of<NewTaskModel>(context, listen: false)
                .customRepetition
                .end
                .setRepetitionEndType(type);
            _endType = type;
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
          },
        );
      }
    }

    return SimpleDialog(
      title: const Text("Custom Repetition Selector"),
      children: [
        Row(
          children: [
            const Text("Repeat every "),
            NumberInput(
              textStyle: Theme.of(context).textTheme.bodyMedium!,
            ),
            const DialogRepetitionDrowndownMenuButton(),
          ],
        ),
        const SizedBox(height: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                groupValue: _endType,
                onChanged: onChange,
              ),
            ),
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
                groupValue: _endType,
                onChanged: onChange,
              ),
            ),
            ListTile(
              title: Row(
                children: [
                  Text(
                    "After",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  NumberInput(
                    textStyle: Theme.of(context).textTheme.bodyMedium!,
                  ),
                  Text(
                    "occurences",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              leading: Radio<RepetitionEndType>(
                value: RepetitionEndType.after,
                groupValue: _endType,
                onChanged: onChange,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
