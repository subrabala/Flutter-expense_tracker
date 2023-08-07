import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';

// appbar 
// starting screen which shows all the expenses
// data present here, can add or delete from the functions available here
class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  // creating a dummy expense using the skeleton we created in models
  final List<Expense> _registeredExpenses = [
    Expense(
        title: 'Flutter Course',
        amount: 19.99,
        date: DateTime.now(),
        category: Category.work),
    Expense(
      title: 'Cinema',
      amount: 15.69,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];

  
  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _deleteExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 3),
      content: const Text('Expense deleted.'),
      action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          }),
    ));
  }

  // showing the drawer to add a new expense
  void _openAddExpenseOverlay() {
    showModalBottomSheet(
        context: context,
        builder: (ctx) => NewExpense(onAddExpense: _addExpense));
  }
  // SUBCOMPONENT NewExpense

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(child: Text("No Expenses Available"));

  // when there's no expense, show the above text, show the list of content
    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
          registeredExpenses: _registeredExpenses,
          onRemoveExpense: _deleteExpense);
    }
    // SUBCOMPONENT ExpensesList

    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Expense Tracker'), actions: [
        IconButton(
            onPressed: _openAddExpenseOverlay, icon: const Icon(Icons.add))
      ]),
      body: Column(
          children: [const Text('The chart'), Expanded(child: mainContent)]),
    );
  }
}
