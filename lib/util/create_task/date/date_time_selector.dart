import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../new_task_model.dart';

class DateTimeSelector extends StatefulWidget {
  const DateTimeSelector({super.key, required this.title});

  final String title;

  @override
  State<DateTimeSelector> createState() => _DateTimeSelectorState();
}

class _DateTimeSelectorState extends State<DateTimeSelector> {
  DateTime selectedDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
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
          if (widget.title == 'Start') {
            Provider.of<NewTaskModel>(context, listen: false).setStartDate(selectedDate);
          } else if (widget.title == 'End') {
            Provider.of<NewTaskModel>(context, listen: false).setEndDate(selectedDate);
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
          if (widget.title == 'Start') {
            Provider.of<NewTaskModel>(context, listen: false).setStartTimeOfDay(picked);
          } else if (widget.title == 'End') {
            Provider.of<NewTaskModel>(context, listen: false).setEndTimeOfDay(picked);
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
          '${widget.title} Date',
          style: TextStyle(
            fontSize: Theme.of(context).textTheme.displaySmall!.fontSize,
            decoration: TextDecoration.underline,
          ),
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
                  side: BorderSide(color: Theme.of(context).colorScheme.primary),
                ),
                padding: const EdgeInsets.all(32.0),
              ),
              child: Text(
                '${widget.title}ing Date: ${selectedDate.month}-${selectedDate.day}-${selectedDate.year}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            ElevatedButton(
              onPressed: () => _selectTime(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.surface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: BorderSide(color: Theme.of(context).colorScheme.primary),
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
        const SizedBox(height: 32),
      ],
    );
  }
}
