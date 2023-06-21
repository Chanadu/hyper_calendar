import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../enums/repetition_types.dart';
import '../../new_task_model.dart';
import 'custom_reptition_dialog.dart';

class RepetitionDropdownMenuButton extends StatefulWidget {
  const RepetitionDropdownMenuButton({
    super.key,
    required this.isDisabled,
  });

  final bool isDisabled;

  @override
  State<RepetitionDropdownMenuButton> createState() => _RepetitionDropdownMenuButtonState();
}

class _RepetitionDropdownMenuButtonState extends State<RepetitionDropdownMenuButton> {
  RepetitionTypes dropdownValue = RepetitionTypes.doesNotRepeat;
  @override
  Widget build(BuildContext context) {
    Null Function(RepetitionTypes?)? onChange = widget.isDisabled
        ? null
        : (RepetitionTypes? value) {
            setState(
              () {
                if (value != null) {
                  dropdownValue = value;

                  Provider.of<NewTaskModel>(context, listen: false)
                      .setRepetitionState(dropdownValue);

                  if (value == RepetitionTypes.custom) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const CustomRepetitionDialog();
                      },
                    );
                  }
                }
              },
            );
          };
    if (onChange == null) {
      dropdownValue = RepetitionTypes.doesNotRepeat;
    }
    return DropdownButton<RepetitionTypes>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward_rounded),
      elevation: 16,
      style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
      iconEnabledColor: Theme.of(context).colorScheme.primary,
      items: RepetitionTypes.values.map((RepetitionTypes value) {
        return DropdownMenuItem<RepetitionTypes>(
          value: value,
          child:
              Text(repetitionTypesToString(value), style: Theme.of(context).textTheme.bodyMedium),
        );
      }).toList(),
      onChanged: onChange,
    );
  }
}
