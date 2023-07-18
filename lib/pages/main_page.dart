import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hyper_calendar/main.dart';
import 'package:hyper_calendar/pages/create_new_task_page.dart';
import 'package:intl/intl.dart';
import '../util/hive_db.dart';
import '../util/holder.dart';
import '../util/main_page/tasks/tasks_holder.dart';
import '../util/mongo_db.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    super.key,
    required this.setSignIn,
  });

  final void Function(bool) setSignIn;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String? username;

  void getUsername() async {
    do {
      try {
        username = (await (await MongoDB.authenticationColl)!.findOne({'_id': usernameId}))!['username'] as String;
      } catch (_) {
        await Future.delayed(const Duration(milliseconds: 100));
      }
    } while (username == null);
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    HiveDB.current.close();
  }

  @override
  Widget build(BuildContext context) {
    if (username == null) getUsername();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hyper Calendar'),
        leading: BackButton(
          onPressed: () {
            showDialog<void>(
              context: context,
              builder: (BuildContext context) {
                return StatefulBuilder(
                  builder: (BuildContext ontext, void Function(void Function()) setState) {
                    return AlertDialog(
                      title: const Text('Back To Sign In'),
                      content: SingleChildScrollView(
                        child: Column(
                          children: [
                            Text(
                              'This will sign you out.',
                              style: TextStyle(
                                fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
                                color: Theme.of(context).colorScheme.error,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Theme.of(context).colorScheme.surface,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      side: BorderSide(color: Theme.of(context).colorScheme.primary),
                                    ),
                                    padding: const EdgeInsets.all(16.0),
                                  ),
                                  child: Text(
                                    'Go Back',
                                    style: Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                ElevatedButton(
                                  onPressed: () {
                                    HiveDB db = HiveDB.current;
                                    db.createInitialData();
                                    db.updateDataBase();
                                    widget.setSignIn(false);
                                    usernameId = null;
                                    Navigator.pop(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Theme.of(context).colorScheme.surface,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      side: BorderSide(color: Theme.of(context).colorScheme.error),
                                    ),
                                    padding: const EdgeInsets.all(16.0),
                                  ),
                                  child: Text(
                                    'Go to Sign In',
                                    style: Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 32,
              top: 4,
            ),
            child: Text(
              username ?? '',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
        ],
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
      floatingActionButton: FloatingActionButton.large(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateNewTaskPage(),
            ),
          ).then((_) => setState(() {}));
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(Icons.add),
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
  List<String> weekdaysList = ['Sun', 'Mon', 'Tues', 'Wed', 'Thurs', 'Fri', 'Sat'];
  DateTime currentMonthYearDate = DateTime(DateTime.now().year, DateTime.now().month, 1);
  DateTime selectedDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  @override
  Widget build(BuildContext context) {
    int firstMonthWeekday = currentMonthYearDate.weekday;
    int calendarWeekStartIndex = firstMonthWeekday == 7 ? 0 : firstMonthWeekday;
    int numberOfDaysInMonth = DateTime(currentMonthYearDate.year, currentMonthYearDate.month + 1, 0).day;
    int numberOfDaysInPreviousMonth = DateTime(currentMonthYearDate.year, currentMonthYearDate.month, 0).day;
    return Column(
      children: [
        Holder(
          padding: const EdgeInsets.only(top: 16, left: 32, right: 32, bottom: 48),
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 2.0 / 3.0,
                child: Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(
                          () {
                            currentMonthYearDate = DateTime(currentMonthYearDate.year, currentMonthYearDate.month - 1, 1);
                          },
                        );
                      },
                      icon: const Icon(Icons.arrow_left_rounded),
                      color: Theme.of(context).colorScheme.primary,
                      iconSize: Platform.isIOS ? 50 : 75,
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
                        setState(
                          () {
                            currentMonthYearDate = DateTime(currentMonthYearDate.year, currentMonthYearDate.month + 1, 1);
                          },
                        );
                      },
                      icon: const Icon(Icons.arrow_right_rounded),
                      color: Theme.of(context).colorScheme.primary,
                      iconSize: Platform.isIOS ? 50 : 75,
                      splashRadius: 35,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: MediaQuery.of(context).size.width * 2.0 / 3.0,
                child: Row(
                  children: [
                    for (int i = 0; i < weekdaysList.length; i++)
                      Expanded(
                        child: Center(
                          child: Text(weekdaysList[i]),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Theme.of(context).colorScheme.primary),
                  borderRadius: BorderRadius.circular(16),
                ),
                height: MediaQuery.of(context).size.height * 4.0 / 7.0 + 2, // math and stuff
                width: MediaQuery.of(context).size.width * 2.0 / 3.0,
                child: GridView.count(
                  crossAxisCount: 7,
                  childAspectRatio: MediaQuery.of(context).size.width / MediaQuery.of(context).size.height,
                  children: [
                    for (int i = 1; i <= 42; i++)
                      Container(
                        decoration: BoxDecoration(
                          border: i > calendarWeekStartIndex &&
                                  i < numberOfDaysInMonth + 1 + calendarWeekStartIndex &&
                                  i - calendarWeekStartIndex == selectedDate.day &&
                                  DateTime(selectedDate.year, selectedDate.month, 1).isAtSameMomentAs(currentMonthYearDate)
                              ? Border.all(color: Theme.of(context).colorScheme.primary)
                              : Border.all(color: Theme.of(context).colorScheme.primaryContainer),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                          child: i > calendarWeekStartIndex
                              ? i < numberOfDaysInMonth + 1 + calendarWeekStartIndex
                                  ? Container(
                                      width: double.infinity,
                                      height: double.infinity,
                                      decoration: BoxDecoration(
                                        border: i > calendarWeekStartIndex &&
                                                i < numberOfDaysInMonth + calendarWeekStartIndex + 1 &&
                                                i - calendarWeekStartIndex == selectedDate.day &&
                                                DateTime(selectedDate.year, selectedDate.month, 1).isAtSameMomentAs(currentMonthYearDate)
                                            ? Border.all(color: Theme.of(context).colorScheme.primary)
                                            : Border.all(color: Theme.of(context).colorScheme.primaryContainer),
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          setState(
                                            () {
                                              selectedDate = DateTime(currentMonthYearDate.year, currentMonthYearDate.month, i - calendarWeekStartIndex);
                                            },
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Theme.of(context).colorScheme.surface,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(16),
                                          ),
                                          elevation: 0,
                                          padding: const EdgeInsets.all(0.0),
                                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                        ),
                                        child: Text(
                                          '${i - calendarWeekStartIndex}',
                                          style:
                                              DateTime.now().day == i - calendarWeekStartIndex && DateTime.now().month == currentMonthYearDate.month && DateTime.now().year == currentMonthYearDate.year
                                                  ? TextStyle(
                                                      fontSize: Theme.of(context).textTheme.labelSmall!.fontSize,
                                                      color: Theme.of(context).colorScheme.primary,
                                                    )
                                                  : TextStyle(
                                                      fontSize: Theme.of(context).textTheme.labelSmall!.fontSize,
                                                    ),
                                        ),
                                      ),
                                    )
                                  : Text(
                                      '${(i - calendarWeekStartIndex) % numberOfDaysInMonth}',
                                      style: TextStyle(
                                        fontSize: Theme.of(context).textTheme.labelSmall!.fontSize,
                                        color: Theme.of(context).colorScheme.surfaceVariant,
                                      ),
                                    )
                              : numberOfDaysInPreviousMonth == 31
                                  ? Text(
                                      '${(i - calendarWeekStartIndex - 1) % 32}',
                                      style: TextStyle(
                                        fontSize: Theme.of(context).textTheme.labelSmall!.fontSize,
                                        color: Theme.of(context).colorScheme.surfaceVariant,
                                      ),
                                    )
                                  : numberOfDaysInPreviousMonth == 30
                                      ? Text(
                                          '${(i - calendarWeekStartIndex - 1) % 31}',
                                          style: TextStyle(
                                            fontSize: Theme.of(context).textTheme.labelSmall!.fontSize,
                                            color: Theme.of(context).colorScheme.surfaceVariant,
                                          ),
                                        )
                                      : Text(
                                          '${(i - calendarWeekStartIndex - 1) % 29}',
                                          style: TextStyle(
                                            fontSize: Theme.of(context).textTheme.labelSmall!.fontSize,
                                            color: Theme.of(context).colorScheme.surfaceVariant,
                                          ),
                                        ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        TasksHolder(selectedDate: selectedDate),
      ],
    );
  }
}
