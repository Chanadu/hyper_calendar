import 'package:flutter/material.dart';
import 'package:hyper_calendar/util/create_task/new_task_model.dart';
import 'package:provider/provider.dart';

class RepetitionSelector extends StatefulWidget {
  const RepetitionSelector({super.key});
  @override
  State<RepetitionSelector> createState() => _RepetitionSelectorState();
}

class _RepetitionSelectorState extends State<RepetitionSelector> {
  @override
  Widget build(BuildContext context) {
    bool isAvailable = context.watch<NewTaskModel>().isOneDayTask;

    if (isAvailable) {
      return DropdownMenuButton(isDisabled: false);
    } else {
      return DropdownMenuButton(isDisabled: true);
    }
  }
}

class DropdownMenuButton extends StatefulWidget {
  DropdownMenuButton({
    super.key,
    required this.isDisabled,
  });

  final bool isDisabled;
  final List<String> list = <String>['Does not Repeat', 'Daily', 'Weekly', 'Yearly', 'Custom'];

  @override
  State<DropdownMenuButton> createState() => _DropdownMenuButtonState();
}

class _DropdownMenuButtonState extends State<DropdownMenuButton> {
  String dropdownValue = "Does not Repeat";
  @override
  Widget build(BuildContext context) {
    Null Function(String?)? onChange = widget.isDisabled
        ? null
        : (String? value) {
            if (!widget.isDisabled) {
              setState(
                () {
                  if (value != null) {
                    dropdownValue = value;
                    if (value == "Custom") {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return SimpleDialog(
                            title: const Text("Custom Repetition Selector"),
                            children: [
                              Row(
                                children: [
                                  const Text("Repeat every "),
                                  NumberInput(min: 0),
                                ],
                              ),
                            ],
                          );
                        },
                      );
                    }
                  }
                },
              );
            }
          };
    if (onChange == null) {
      dropdownValue = "Does not Repeat";
    }
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward_rounded),
      elevation: 16,
      style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
      iconEnabledColor: Theme.of(context).colorScheme.primary,
      items: widget.list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value, style: Theme.of(context).textTheme.bodyMedium),
        );
      }).toList(),
      onChanged: onChange,
    );
  }
}

class NumberInput extends StatefulWidget {
  final int min;

  const NumberInput({
    super.key,
    required this.min,
  });

  @override
  State<NumberInput> createState() => _NumberInputState();
}

class _NumberInputState extends State<NumberInput> {
  int count = 0;

  void increment() {
    setState(() {
      count++;
    });
  }

  void decrement() {
    if (count <= 1) return;
    setState(() {
      count--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SmallIconButton(
          onPressed: increment,
          icon: Icons.arrow_upward_rounded,
        ),
        Text("$count"),
        SmallIconButton(
          onPressed: decrement,
          icon: Icons.arrow_downward_rounded,
        ),
      ],
    );
  }
}

class SmallIconButton extends StatelessWidget {
  const SmallIconButton({super.key, required this.onPressed, required this.icon});

  final Function()? onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: const ShapeDecoration(
        color: Colors.transparent,
        shape: CircleBorder(),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: Theme.of(context).colorScheme.primary,
        ),
        splashRadius: 17,
      ),
    );
  }
}
