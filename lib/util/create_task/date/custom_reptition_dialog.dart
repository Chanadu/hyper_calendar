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

  @override
  Widget build(BuildContext context) {
    var onChange = (RepetitionEndType? type) {
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
    };

    return SimpleDialog(
      title: const Text("Custom Repetition Selector"),
      children: [
        const Row(
          children: [
            Text("Repeat every "),
            NumberInput(),
            DialogRepetitionDrowndownMenuButton(),
          ],
        ),
        const SizedBox(height: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Ends"),
            ListTile(
              title: const Text("Never"),
              leading: Radio<RepetitionEndType>(
                value: RepetitionEndType.never,
                groupValue: _endType,
                onChanged: onChange,
              ),
            ),
            ListTile(
              title: const Text("On"),
              leading: Radio<RepetitionEndType>(
                value: RepetitionEndType.on,
                groupValue: _endType,
                onChanged: onChange,
              ),
            ),
            ListTile(
              title: const Text("After"),
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
