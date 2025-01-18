import 'package:expense_tracker/DataService/SqlLiteService/sqlLiteDB.dart';
import 'package:expense_tracker/widgets/expense_list/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final SQLiteDatabaseService _databaseService = SQLiteDatabaseService
      .instance; //singleton object of sqlite database service

  // final List<Expense> _registeredExpenses=[
  //   Expense(title: "Groceries", amount: 100.0, date: DateTime.now(), category: Category.food),
  //   Expense(title: "Uber", amount: 50.0, date: DateTime.now(), category: Category.travel),
  //   Expense(title: "Movie", amount: 30.0, date: DateTime.now(), category: Category.leisure),
  //   Expense(title: "Laptop", amount: 1500.0, date: DateTime.now(), category: Category.work),
  // ];
  List<Expense> _registeredExpenses = [];

  void _fetchExpenses() async {
    final expenses = await _databaseService.getExpenses();
    setState(() {
      _registeredExpenses = expenses;
    });
    // _registeredExpenses = await _databaseService.getExpenses();
  }

  @override
  void initState() {
    print("Init method called");
    super.initState();
    _fetchExpenses();
  }

  void addExpense(Expense expense) {
    setState(() {
      //insert into the database
      _databaseService.addExpense(expense);
      _registeredExpenses.add(expense);
    });
  }

  void removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Expense removed"),
      duration: Duration(seconds: 2),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          setState(() {
            _registeredExpenses.insert(expenseIndex, expense);
          });
        },
      ),
    ));
  }

  void _openAddExpenseForm() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) {
          return NewExpense(addExpense: addExpense);
        });
  }

  @override
  Widget build(BuildContext context) {
    // _fetchExpenses();
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Expense Tracker"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _openAddExpenseForm,
          )
        ],
      ),
      body: Column(
        children: [
          const Text("The chart"),
          Expanded(
              child: ExpensesList(
            expenses: _registeredExpenses,
            dismiss: removeExpense,
          ))
        ],
      ),
    );
  }
}
