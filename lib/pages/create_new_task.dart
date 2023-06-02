import 'package:flutter/material.dart';
import 'package:hyper_calendar/util/date_input_list_tile.dart';
import '../util/basic_information_tile.dart';

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
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(48.0),
          child: Column(
            children: [
              Holder(
                title: "Basic Information",
                child: BasicInformationTile(),
              ),
              SizedBox(height: 32.0),
              Holder(
                title: "Timings",
                child: DateInputListTile(),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Create",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        onPressed: () {},
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
    return Container(
      padding: const EdgeInsets.only(bottom: 48, top: 32, left: 32, right: 32),
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
    );
  }
}
