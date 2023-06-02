import 'package:flutter/material.dart';

class DateInputListTile extends StatefulWidget {
  const DateInputListTile({
    super.key,
  });

  @override
  State<DateInputListTile> createState() => _DateInputListTileState();
}

class _DateInputListTileState extends State<DateInputListTile> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        DateTimeSelector(title: "Start"),
        SizedBox(height: 32),
        DateTimeSelector(title: "End"),
      ],
    );
  }
}

class DateTimeSelector extends StatefulWidget {
  const DateTimeSelector({super.key, required this.title});

  final String title;

  @override
  State<DateTimeSelector> createState() => _DateTimeSelectorState();
}

class _DateTimeSelectorState extends State<DateTimeSelector> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      setState(
        () {
          selectedDate = picked;
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "${widget.title} Date",
          style: Theme.of(context).textTheme.displaySmall,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16.0),
        Wrap(
          alignment: WrapAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () => _selectDate(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.surface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side:
                      BorderSide(color: Theme.of(context).colorScheme.primary),
                ),
                padding: const EdgeInsets.all(32.0),
              ),
              child: Text(
                "${widget.title}ing Date: ${selectedDate.month}-${selectedDate.day}-${selectedDate.year}",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            ElevatedButton(
              onPressed: () => _selectTime(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.surface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side:
                      BorderSide(color: Theme.of(context).colorScheme.primary),
                ),
                padding: const EdgeInsets.all(32.0),
              ),
              child: Text(
                "${widget.title} Time: ${selectedTime.hourOfPeriod}:${selectedTime.minute.toString().padLeft(2, "0")} ${selectedTime.period.toString().split('.')[1].toUpperCase()}",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
