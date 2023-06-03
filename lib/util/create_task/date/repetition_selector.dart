import 'package:flutter/material.dart';
import 'package:hyper_calendar/util/create_task/new_task_model.dart';
import 'package:provider/provider.dart';

class RepetitionSelector extends StatefulWidget {
  RepetitionSelector({super.key});

  final List<String> list = <String>[
    'Does not Repeat',
    'Daily',
    'Weekly',
    'Yearly',
    'Custom'
  ];

  @override
  State<RepetitionSelector> createState() => _RepetitionSelectorState();
}

class _RepetitionSelectorState extends State<RepetitionSelector> {
  String dropdownValue = "Does not Repeat";

  @override
  Widget build(BuildContext context) {
    DropdownButton dropdown = DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
      iconEnabledColor: Theme.of(context).colorScheme.primary,
      items: widget.list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? value) {
        setState(() {
          if (value != null) {
            dropdownValue = value;
          }
        });
      },
    );

    bool isAvailable = context.watch<NewTaskModel>().isOneDayTask;

    if (isAvailable) {
      return dropdown;
    }
    return Text("A");
  }
}
