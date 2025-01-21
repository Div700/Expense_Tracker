
import 'package:expense_tracker/domain/Services/expense_service.dart';
import 'package:expense_tracker/presentation/widgets/expense_list/expenses_list.dart';
import 'package:expense_tracker/presentation/widgets/add_expense/new_expense.dart';
import 'package:flutter/material.dart';

//upper level Stateful widget for the expense app
class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {

  //instance of Expense service usecase
  final expenseService = ExpenseService();
  List<Map<String,dynamic>> _registeredExpenses = [];
  _ExpensesState()
  {
    print("Constructor called");
  }

  void _fetchExpenses() async 
  {
    final expenses = await expenseService.fetchExpenses();
    setState(() {
      _registeredExpenses = expenses; //updating the list of expenses for the UI
    });
  }

  @override
  void initState() {
    print("Init method called");
    super.initState();
    _fetchExpenses(); //initializing the expense list
  }

  /*function for adding a new expense in the expense list, and correspondingly updating
  UI and the database*/

  void addExpense(Map<String,dynamic> newExpenseMap) async
  {
    expenseService.addExpense(newExpenseMap);
    List<Map<String,dynamic>> allExpenses = await expenseService.fetchExpenses();
    setState(() {
      _registeredExpenses = allExpenses;
    });
  }

  /* function for removing any expense from the list. 
  The user can simply slide the expense and remove from the list */
  void removeExpense(int uid) async{
 final expenseIndex = _registeredExpenses.indexWhere((expense) => expense['uid'] == uid);
 final expenseToRemove = _registeredExpenses[expenseIndex];
    expenseService.removeExpense(uid);
        List<Map<String,dynamic>> allExpenses = await expenseService.fetchExpenses();

    setState(() {
      // _registeredExpenses.remove(expense);
      _registeredExpenses = allExpenses;
    });
    //The user can undo if he slides the expense by mistake
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Expense removed"),
      duration: Duration(seconds: 2),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          expenseService.addExpense(expenseToRemove); //inserting again
          setState(() {
            _registeredExpenses.insert(expenseIndex, expenseToRemove);
          });
        },
      ),
    ));
  }
  
  //function for opening the add expense form
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
          // Chart(expenses: _registeredExpenses),
          
          // Text("chart"),
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
