import 'package:flutter/material.dart';

import 'dividers.dart';

class DateInputListTile extends StatefulWidget {
  const DateInputListTile({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<DateInputListTile> createState() => _DateInputListTileState();
}

class _DateInputListTileState extends State<DateInputListTile> {
  DateTime selectedStartDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

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

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      orientation: Orientation.portrait,
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      setState(
        () {
          selectedTime = picked;
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Starting Date: ${selectedStartDate.month}-${selectedStartDate.day}-${selectedStartDate.year}",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    ElevatedButton(
                      onPressed: () => _selectDate(context, true),
                      child: const Text('Pick Another Date'),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25.0,
                ),
                FullDivider(context: context, width: 150, height: 2),
                const SizedBox(
                  height: 25.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Ending Date: ${selectedEndDate.month}-${selectedEndDate.day}-${selectedEndDate.year}",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    ElevatedButton(
                      onPressed: () => _selectDate(context, false),
                      child: const Text('Pick Another Date'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          FullDivider(
            context: context,
            width: 5.0,
            height: 200.0,
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Time Selected: ${selectedTime.hourOfPeriod}:${selectedTime.minute.toString().padLeft(2, "0")} ${selectedTime.period.toString().split('.')[1].toUpperCase()}",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                ElevatedButton(
                  onPressed: () => _selectTime(context),
                  child: const Text('Pick a Time'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
