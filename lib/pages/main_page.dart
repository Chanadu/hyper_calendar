import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hyper Calendar"),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(child: MainCalendar()),
            ],
          ),
        ),
      ),
    );
  }
}

class MainCalendar extends StatefulWidget {
  const MainCalendar({super.key});

  @override
  State<MainCalendar> createState() => _MainCalendarState();
}

class _MainCalendarState extends State<MainCalendar> {
  DateTime currentMonthYearDate = DateTime(DateTime.now().year, DateTime.now().month, 1);

  @override
  Widget build(BuildContext context) {
    int firstMonthWeekday = currentMonthYearDate.weekday;
    int calendarWeekStartIndex = firstMonthWeekday == 7 ? 0 : firstMonthWeekday;
    int numberOfDaysInMonth = DateTime(currentMonthYearDate.year, currentMonthYearDate.month + 1, 0).day;
    int numberOfDaysInPreviousMonth = DateTime(currentMonthYearDate.year, currentMonthYearDate.month, 0).day;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  currentMonthYearDate = DateTime(currentMonthYearDate.year, currentMonthYearDate.month - 1, 1);
                });
              },
              icon: const Icon(Icons.arrow_left_rounded),
              color: Theme.of(context).colorScheme.primary,
              iconSize: 75,
              splashRadius: 35,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Text(
                DateFormat('MMM. yyyy').format(currentMonthYearDate),
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  currentMonthYearDate = DateTime(currentMonthYearDate.year, currentMonthYearDate.month + 1, 1);
                });
              },
              icon: const Icon(Icons.arrow_right_rounded),
              color: Theme.of(context).colorScheme.primary,
              iconSize: 75,
              splashRadius: 35,
            ),
          ],
        ),
        Container(
          width: MediaQuery.of(context).size.width * 2.0 / 3.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Sun"),
              Text("Mon"),
              Text("Tues"),
              Text("Wed"),
              Text("Thurs"),
              Text("Fri"),
              Text("Sat"),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).colorScheme.primary),
            borderRadius: BorderRadius.circular(16),
          ),
          child: SizedBox(
            height: 4.0 / 7.0 * MediaQuery.of(context).size.height, // good math
            width: MediaQuery.of(context).size.width * 2.0 / 3.0,
            child: GridView.count(
              crossAxisCount: 7,
              childAspectRatio: MediaQuery.of(context).size.width / MediaQuery.of(context).size.height,
              children: [
                for (int i = 1; i <= 42; i++)
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).colorScheme.primaryContainer),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: i > calendarWeekStartIndex
                          ? i < numberOfDaysInMonth + 1 + calendarWeekStartIndex
                              ? Text(
                                  '${i - calendarWeekStartIndex}',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                )
                              : Text(
                                  '${(i - calendarWeekStartIndex) % numberOfDaysInMonth}',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                )
                          : numberOfDaysInPreviousMonth == 31
                              ? Text(
                                  '${(i - calendarWeekStartIndex - 1) % 32}',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                )
                              : numberOfDaysInPreviousMonth == 30
                                  ? Text(
                                      '${(i - calendarWeekStartIndex - 1) % 31}',
                                      style: Theme.of(context).textTheme.bodyMedium,
                                    )
                                  : Text(
                                      '${(i - calendarWeekStartIndex - 1) % 29}',
                                      style: Theme.of(context).textTheme.bodyMedium,
                                    ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/*
? Text(
                                '${i - calendarWeekStartIndex}',
                                style: Theme.of(context).textTheme.bodyMedium,
                              )
                            : Text(
                                '${(i - calendarWeekStartIndex) % 31}',
                                style: Theme.of(context).textTheme.bodyMedium,
                              )
                        : Text(
                            '${(i - calendarWeekStartIndex - 1) % 32}',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
*/