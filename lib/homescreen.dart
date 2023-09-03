import 'package:flutter/material.dart';
import 'expense.dart';

class ExpenseTrackerHomePage extends StatefulWidget {
  @override
  _ExpenseTrackerHomePageState createState() => _ExpenseTrackerHomePageState();
}

class _ExpenseTrackerHomePageState extends State<ExpenseTrackerHomePage> {
  double totalExpense = 0;
  List<Expense> expenses = [];

  void _showExpenseDialog(BuildContext context) {
    String expenseName = '';
    double expenseAmount = 0;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0))),
          backgroundColor: const Color.fromRGBO(84, 83, 84, 1.0),
          title:
              const Text('Add Expense', style: TextStyle(color: Colors.white)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                    labelText: 'Expense Name',
                    hintStyle: TextStyle(color: Colors.white)),
                onChanged: (value) {
                  expenseName = value;
                },
              ),
              TextField(
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: ('Expense Amount'),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  expenseAmount = double.tryParse(value) ?? 0;
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child:
                  const Text('Cancel', style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Spent', style: TextStyle(color: Colors.white)),
              onPressed: () {
                if (expenseName.isNotEmpty && expenseAmount > 0) {
                  setState(() {
                    expenses.add(Expense(expenseName, -expenseAmount));
                    totalExpense += expenseAmount;
                  });
                  Navigator.of(context).pop();
                }
              },
            ),
            TextButton(
              child:
                  const Text('Received', style: TextStyle(color: Colors.white)),
              onPressed: () {
                if (expenseName.isNotEmpty && expenseAmount > 0) {
                  setState(() {
                    expenses.add(Expense(expenseName, expenseAmount));
                    totalExpense -= expenseAmount;
                  });
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  void removeExpense(int index) {
    if (expenses[index].amount > 0) {
      setState(() {
        totalExpense -= expenses[index].amount;
        expenses.removeAt(index);
      });
    } else {
      setState(() {
        totalExpense += expenses[index].amount;
        expenses.removeAt(index);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Expense Tracker', style: TextStyle(fontWeight: FontWeight.w400),)),
        backgroundColor: const Color.fromRGBO(84, 52, 104, 1.0),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: const BoxDecoration(boxShadow: [BoxShadow(blurRadius: 5)],
                  color: Color.fromRGBO(84, 52, 104, 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0))),
              height: screenHeight * 0.2,
              width: screenWidth * 0.9,
              child: Center(
                child: Text(
                  totalExpense >= 0
                      ? 'You have spent: \u{20B9}${totalExpense.toStringAsFixed(2)}'
                      : 'You have earned: \u{20B9}${(-totalExpense).toStringAsFixed(2)}',
                  style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w300),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: expenses.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  shape: const RoundedRectangleBorder(
                      side: BorderSide(width: 4, color: Colors.white),
                      borderRadius: BorderRadius.all(Radius.circular(16.0))),
                  tileColor: expenses[index].amount > 0
                      ? Colors.greenAccent
                      : Colors.redAccent,
                  title: Text(expenses[index].name),
                  subtitle: Text(
                      '\u{20B9}${expenses[index].amount.toStringAsFixed(2)}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      removeExpense(index);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showExpenseDialog(context);
        },
        tooltip: 'Add Expense',
        label: const Text(
          "Add expense",
          style: TextStyle(fontWeight: FontWeight.w400),
        ),
        icon: const Icon(Icons.add),
        elevation: 5,
        backgroundColor: const Color.fromRGBO(84, 52, 104, 1.0),
      ),
    );
  }
}
