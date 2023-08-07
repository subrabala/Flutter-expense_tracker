import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expense_item.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key,
      required this.registeredExpenses,
      required this.onRemoveExpense});

  final List<Expense> registeredExpenses;
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: registeredExpenses.length,
      itemBuilder: (ctx, index) => Dismissible(
          key: ValueKey(registeredExpenses[index]),
          onDismissed: (direction) {
            onRemoveExpense(registeredExpenses[index]);
          },
          child: ExpenseItem(registeredExpenses[index])),
          // SUBCONTENT ExpenseItem
    );
  }
}
