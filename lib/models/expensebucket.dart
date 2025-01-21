import 'package:expense_tracker/models/enums/category_enum.dart';
import 'package:expense_tracker/models/expense.dart';

class ExpenseBucket{

ExpenseBucket.forCategory(List<Expense> allExpenses, this.category) :
 expenses = allExpenses.where((expense) => expense.category == category).toList();

  ExpenseBucket(this.category, this.expenses);
  final Category category;
  final List<Expense> expenses;

  double get totalExpenses{
    double sum = 0;
    for(final expense in expenses){
      sum += expense.amount;
    }
    return sum;
  }
}