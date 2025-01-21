import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/presentation/utils/constants.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget
{
  final Map<String,dynamic> expense;
  const ExpenseItem({super.key, required this.expense});

  @override
  Widget build(BuildContext context) 
  {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 16
      ),
      child: (
        Card(
          child: Column(children: [
            Text(expense['title']),
            const SizedBox(height: 5,),
            Row(
              children: [
                Text('\$${expense['amount'].toStringAsFixed(2)}'),
                const Spacer(), //to push right row to rightside
                Row(children: [
                  Icon(categoryIcons[expense['category']]),
                  const SizedBox(width: 6,),
                  Text(expense['date'])
                ],)
              ],
            )
          ],),
        )
      ),
    );
  }
  
}