import 'package:flutter/material.dart';

import '../util/create_task/basic/basic_information_tile.dart';
import '../util/create_task/date/date_input_list_tile.dart';

class CreateNewTask extends StatelessWidget {
  const CreateNewTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "New Task",
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: [
              const Holder(
                title: "Basic Information",
                child: BasicInformationTile(),
              ),
              const Holder(
                title: "Timings",
                child: DateInputListTile(),
              ),
              const Holder(
                title: "Reminders",
                child: Placeholder(),
              ),
              ElevatedButton(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Create",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Holder extends StatelessWidget {
  const Holder({
    super.key,
    required this.child,
    required this.title,
  });

  final Widget child;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding:
              const EdgeInsets.only(bottom: 48, top: 32, left: 32, right: 32),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: Theme.of(context).colorScheme.surface,
          ),
          child: Column(
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 32.0),
              child,
            ],
          ),
        ),
        const SizedBox(height: 32.0),
      ],
    );
  }
}
