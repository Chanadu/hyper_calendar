import 'package:flutter/material.dart';

import 'date_time_selector.dart';
import 'repetition_selector.dart';

class DateInputListTile extends StatelessWidget {
  const DateInputListTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        DateTimeSelector(title: 'Start'),
        DateTimeSelector(title: 'End'),
        RepetitionSelector(),
      ],
    );
  }
}
