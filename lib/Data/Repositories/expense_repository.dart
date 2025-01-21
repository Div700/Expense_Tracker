import 'package:expense_tracker/Data/LocalDB/SqlLite/sql_queries.dart';
import 'package:expense_tracker/Data/LocalDB/SqlLite/sqlite.dart';
import 'package:expense_tracker/Data/database.dart';
import 'package:expense_tracker/models/expense.dart';

class Expense_Repository
{
  static final Database_layer dbObj = Sqlite.instance;
  
  void addExpense(Expense expense) async
  {
    await dbObj.insert(SqlQueries.tableName, expense.toMap());
  }

  Future<List<Expense>> fetchExpenses() async
  {
    final List<dynamic> allExpenses = await dbObj.read(SqlQueries.tableName);
    //converting the fetched list of maps back into the model
    return List.generate(allExpenses.length, (i) 
    {
      return Expense.fromMap(allExpenses[i]);
    });
  }
  void removeExpense(int uid) async
  {
    await dbObj.delete(SqlQueries.tableName, uid);
  }
}