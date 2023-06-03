import 'package:flutter/material.dart';

import 'date_time_selector.dart';
import 'repetition_selector.dart';

class DateInputListTile extends StatelessWidget {
  const DateInputListTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const DateTimeSelector(title: "Start"),
        const DateTimeSelector(title: "End"),
        RepetitionSelector(),
      ],
    );
  }
}
