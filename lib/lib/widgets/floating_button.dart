import 'package:flutter/material.dart';
import 'package:exp_tracker/homescreen.dart';
class FloatingButton extends StatefulWidget {
  const FloatingButton({Key? key}) : super(key: key);

  @override
  State<FloatingButton> createState() => _FloatingButtonState();
}

class _FloatingButtonState extends State<FloatingButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      tooltip: 'Add Expense',
      label: const Text("Add expense"),
      icon: const Icon(Icons.add),
      elevation: 5,
      backgroundColor: const Color.fromRGBO(84, 52, 104, 1.0), onPressed: () {  },
    );
  }
}
