import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../enums/custom_repetition_types.dart';
import '../new_task_model.dart';

class DialogRepetitionDrowndownMenuButton extends StatefulWidget {
  const DialogRepetitionDrowndownMenuButton({
    super.key,
  });
  @override
  State<DialogRepetitionDrowndownMenuButton> createState() =>
      _DialogRepetitionDrowndownMenuButtonState();
}

class _DialogRepetitionDrowndownMenuButtonState extends State<DialogRepetitionDrowndownMenuButton> {
  CustomRepetitionTypes dropdownValue = CustomRepetitionTypes.days;
  @override
  Widget build(BuildContext context) {
    return DropdownButton<CustomRepetitionTypes>(
      value: dropdownValue,
      icon: Icon(Icons.arrow_downward_rounded, color: Theme.of(context).colorScheme.primary),
      elevation: 16,
      style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
      items: CustomRepetitionTypes.values.map((CustomRepetitionTypes value) {
        return DropdownMenuItem<CustomRepetitionTypes>(
          value: value,
          child: Text(
            customRepetitionTypesToString(value),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        );
      }).toList(),
      onChanged: (value) {
        setState(
          () {
            if (value != null) {
              dropdownValue = value;
              Provider.of<NewTaskModel>(context, listen: false).customRepetition.setType(value);
            }
          },
        );
      },
    );
  }
}
