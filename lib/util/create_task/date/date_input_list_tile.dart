import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        DateTimeSelector(title: "Start"),
        DateTimeSelector(title: "End"),
        RepetitionSelector(),
      ],
    );
  }
}

// class DateTimeModel extends ChangeNotifier {
//   DateTime startDate = DateTime.now();
//   DateTime endDate = DateTime.now();

//   bool get isOneDayEvent => startDate.isAtSameMomentAs(endDate);

//   DateTime getStartDate() => startDate;
//   DateTime getEndDate() => endDate;
//   void setStartDate(DateTime startDate) {
//     this.startDate = startDate;
//     notifyListeners();
//   }

//   void setEndDate(DateTime endDate) {
//     this.endDate = endDate;
//     notifyListeners();
//   }
// }
