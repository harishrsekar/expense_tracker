import 'package:flutter/material.dart';
import 'homescreen.dart';

void main() {
  runApp(ExpenseTrackerApp());
}

class ExpenseTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      title: 'Expense Tracker App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ExpenseTrackerHomePage(),
    );
  }
}
