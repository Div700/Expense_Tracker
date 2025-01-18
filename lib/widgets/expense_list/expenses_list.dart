
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expense_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  final List<Expense> expenses;
  final void Function (Expense) dismiss;

  const ExpensesList({super.key, 
  required this.expenses,
  required this.dismiss});

  @override
  Widget build(BuildContext context) 
  {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) {
        return Dismissible(
          key: ValueKey(expenses[index]),
          child: ExpenseItem(expense:  expenses[index]),
          onDismissed: (direction){
            dismiss(expenses[index]);
          },);
        }
        )
      ;
  }

}