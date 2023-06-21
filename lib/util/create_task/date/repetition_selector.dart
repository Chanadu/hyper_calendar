import 'package:flutter/material.dart';
import 'package:hyper_calendar/util/new_task_model.dart';
import 'package:provider/provider.dart';

import 'repetition_dropdown_menu_button.dart';

class RepetitionSelector extends StatefulWidget {
  const RepetitionSelector({super.key});
  @override
  State<RepetitionSelector> createState() => _RepetitionSelectorState();
}

class _RepetitionSelectorState extends State<RepetitionSelector> {
  @override
  Widget build(BuildContext context) {
    bool isAvailable = context.watch<NewTaskModel>().isOneDayTask;

    if (isAvailable) {
      return const RepetitionDropdownMenuButton(isDisabled: false);
    } else {
      return const RepetitionDropdownMenuButton(isDisabled: true);
    }
  }
}
