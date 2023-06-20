import 'package:flutter/material.dart';

import 'create_new_task.dart';
import 'dividers.dart';

class DayPage extends StatefulWidget {
  const DayPage({super.key, required this.title});
  final String title;

  @override
  State<DayPage> createState() => _DayPageState();
}

class _DayPageState extends State<DayPage> {
  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final controller = TextEditingController();

    Decoration objectDecoration = BoxDecoration(
      color: Theme.of(context).colorScheme.primary,
      borderRadius: const BorderRadius.all(Radius.circular(5)),
    );

    void saveNewTask() {
      setState(() {
        _controller.clear();
      });
      Navigator.of(context).pop();
    }

    void createNewTask() {
      showDialog(
        context: context,
        builder: (context) {
          return NewTask(
            controller: controller,
            onSave: saveNewTask,
            onCancel: () => Navigator.of(context).pop(),
          );
        },
      );
    }

    TextStyle? textStyle = themeData.textTheme.bodyMedium;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: themeData.textTheme.titleLarge,
        ),
        backgroundColor: themeData.colorScheme.surface,
      ),
      backgroundColor: themeData.colorScheme.surface,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
              top: 16.0, bottom: 16.0, left: 64.0, right: 64.0),
          child: Column(
            children: [
              for (int i = 0; i < 24; i++)
                Column(
                  children: [
                    TimeRow(
                      objectDecoration: objectDecoration,
                      i: i,
                      textStyle: textStyle,
                    ),
                    const HeightSpacer(),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(25),
                            decoration: objectDecoration,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                '$screenWidth $screenHeight',
                                style: textStyle,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const HeightSpacer(),
                  ],
                ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.large(
        backgroundColor: themeData.colorScheme.secondary,
        onPressed: createNewTask,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class TimeRow extends StatelessWidget {
  const TimeRow({
    super.key,
    required this.objectDecoration,
    required this.i,
    required this.textStyle,
  });

  final Decoration objectDecoration;
  final int i;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LeftDivider(objectDecoration: objectDecoration),
        Container(
          margin: const EdgeInsets.only(left: 16, right: 16),
          child: Text(
            textAlign: TextAlign.center,
            "${i % 12 + 1} ${i - 12 < 0 ? "AM" : "PM"}",
            style: textStyle,
          ),
        ),
        RightDivider(objectDecoration: objectDecoration),
      ],
    );
  }
}
