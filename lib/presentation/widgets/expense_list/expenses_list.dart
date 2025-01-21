
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/presentation/widgets/expense_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  final List<Map<String,dynamic>> expenses;
  final void Function (int) dismiss;

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
            print("Entry to be removed : ${expenses[index]['uid']}");
            dismiss(expenses[index]['uid']);
          },);
        }
        )
      ;
  }

}