import 'package:flutter/material.dart';

class DateInputListTile extends StatefulWidget {
  const DateInputListTile({
    super.key,
  });

  @override
  State<DateInputListTile> createState() => _DateInputListTileState();
}

class _DateInputListTileState extends State<DateInputListTile> {
  DateTime selectedStartDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();
  TimeOfDay selectedStartTime = TimeOfDay.now();
  TimeOfDay selectedEndTime = TimeOfDay.now();

  Future<void> _selectDate(BuildContext context, bool start) async {
    DateTime d = start ? selectedStartDate : selectedEndDate;
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: d,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != d) {
      setState(
        () {
          if (start) {
            selectedStartDate = picked;
          } else {
            selectedEndDate = picked;
          }
        },
      );
    }
  }

  Future<void> _selectTime(BuildContext context, bool start) async {
    TimeOfDay t = start ? selectedStartTime : selectedEndTime;
    final TimeOfDay? picked = await showTimePicker(
      orientation: Orientation.portrait,
      context: context,
      initialTime: t,
    );
    if (picked != null && picked != t) {
      setState(
        () {
          if (start) {
            selectedStartTime = picked;
          } else {
            selectedEndTime = picked;
          }
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "Start Date",
          style: Theme.of(context).textTheme.displaySmall,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16.0),
        Wrap(
          alignment: WrapAlignment.spaceEvenly,
          children: [
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () => _selectDate(context, true),
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(
                        color: Theme.of(context).colorScheme.primary),
                  ),
                  child: Text(
                    "Starting Date: ${selectedStartDate.month}-${selectedStartDate.day}-${selectedStartDate.year}",
                  ),
                ),
              ),
            ),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () => _selectTime(context, true),
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(
                        color: Theme.of(context).colorScheme.primary),
                  ),
                  child: Text(
                    "Time Selected: ${selectedStartTime.hourOfPeriod}:${selectedStartTime.minute.toString().padLeft(2, "0")} ${selectedStartTime.period.toString().split('.')[1].toUpperCase()}",
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 32),
        Text(
          "End Date",
          style: Theme.of(context).textTheme.displaySmall,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16.0),
        Wrap(
          alignment: WrapAlignment.spaceEvenly,
          children: [
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () => _selectDate(context, false),
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(
                        color: Theme.of(context).colorScheme.primary),
                  ),
                  child: Text(
                    "Starting Date: ${selectedEndDate.month}-${selectedEndDate.day}-${selectedEndDate.year}",
                  ),
                ),
              ),
            ),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () => _selectTime(context, true),
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(
                        color: Theme.of(context).colorScheme.primary),
                  ),
                  child: Text(
                    "Time Selected: ${selectedEndTime.hourOfPeriod}:${selectedEndTime.minute.toString().padLeft(2, "0")} ${selectedEndTime.period.toString().split('.')[1].toUpperCase()}",
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}


/*

                    ElevatedButton(
                      onPressed: () => _selectDate(context, true),
                      child: const Text('Pick Another Date'),
                    ),
                    ElevatedButton(
                      onPressed: () => _selectDate(context, false),
                      child: const Text('Pick Another Date'),
                    ),
                      "Ending Date: ${selectedEndDate.month}-${selectedEndDate.day}-${selectedEndDate.year}",
                ElevatedButton(
                  onPressed: () => _selectTime(context, true),
                  child: const Text('Pick a Time'),
                ),
                "Time Selected: ${selectedStartTime.hourOfPeriod}:${selectedStartTime.minute.toString().padLeft(2, "0")} ${selectedStartTime.period.toString().split('.')[1].toUpperCase()}",
                  

*/