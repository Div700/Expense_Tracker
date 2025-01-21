import 'package:expense_tracker/Data/Repositories/expense_repository.dart';
import 'package:expense_tracker/models/expense.dart';

//validation
//use repository to contact with database
class ExpenseService 
{
  final Expense_Repository expenseRepository = Expense_Repository();
  static int _uid = 0;

  void addExpense(Map<String,dynamic> expenseMap)
  {
    _uid++;
    expenseMap['uid'] = _uid;
    print('Incoming new expense : $expenseMap');
    Expense newExpense = Expense.fromMap(expenseMap);
    expenseRepository.addExpense(newExpense);
  }

  Future<List<Map<String,dynamic>>> fetchExpenses() async
  {
    List<Expense> expenses = await expenseRepository.fetchExpenses();
    
    if(_uid == 0) {
      _uid = expenses.last.uid;
    }
     List<Map<String, dynamic>> expensesMapList = expenses.map((expense) {
    return expense.toMap(); // Call toMap() directly here
  }).toList();

    return expensesMapList;
  }
  void removeExpense(int uid)
  {
    expenseRepository.removeExpense(uid);
  }

}