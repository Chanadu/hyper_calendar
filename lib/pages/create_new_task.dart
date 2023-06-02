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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextInputListTile(
                title: "Event Name",
                hint: "",
                controller: TextEditingController(),
                maxLines: 1,
              ),
              TextInputListTile(
                title: "Description",
                hint: "",
                controller: TextEditingController(),
                maxLines: 3,
              ),
              ColorSelector(),
              // const DateInputListTile(
              //   title: "Date",
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
