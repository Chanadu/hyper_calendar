import 'package:flutter/material.dart';

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
        child: Column(
          children: [
            Center(child: MainCalendar()),
          ],
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
  int calendarWeekStartIndex = 5;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.primary,
            ),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          padding: EdgeInsets.all(16.0),
          child: Text(
            "Mar. 2000",
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ),
        SizedBox(
          height: 800,
          width: 800,
          child: GridView.count(
            crossAxisCount: 7,
            padding: const EdgeInsets.all(8),
            children: [
              for (int i = 1; i <= 42; i++)
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: i > calendarWeekStartIndex
                      ? i < 32 + calendarWeekStartIndex
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
                ),
            ],
          ),
        ),
      ],
    );
  }
}
