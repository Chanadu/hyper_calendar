import 'package:flutter/material.dart';
import '../util/color_selector.dart';
import '../util/text_input_list_tile.dart';

class CreateNewTask extends StatelessWidget {
  const CreateNewTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Create a New Task",
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(
                    bottom: 48, top: 32, left: 32, right: 32),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: Theme.of(context).colorScheme.surface,
                ),
                child: Column(
                  children: [
                    TextInputListTile(
                      title: "Event Name",
                      hint: "",
                      controller: TextEditingController(),
                      maxLines: 1,
                    ),
                    const SizedBox(height: 10),
                    TextInputListTile(
                      title: "Description",
                      hint: "",
                      controller: TextEditingController(),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 30),
                    const ColorSelector(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
