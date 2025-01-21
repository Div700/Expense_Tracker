
import 'package:expense_tracker/Data/LocalDB/SqlLite/sql_queries.dart';
import 'package:expense_tracker/models/enums/category_enum.dart';
import 'package:intl/intl.dart';

DateFormat dateFormat = DateFormat.yMd();
class Expense 
{
  final int uid;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  Expense(
    {required this.title, 
    required this.amount,
    required this.date,
    required this.category,
    required this.uid}); 
  
    factory Expense.fromMap(Map<String, dynamic> map) {
  // Debugging: Print the entire map and the 'date' value to check for potential issues
  print('Expense map: $map');
  print('Date value: ${map[SqlQueries.date]}');

  // Safely parse the date value, falling back to DateTime.now() if parsing fails
  DateTime date;
  try {
    date = DateTime.tryParse(map[SqlQueries.date]?.toString() ?? '') ?? DateTime.now();
  } catch (e) {
    print('Error parsing date: $e');
    date = DateTime.now();  // Fallback to current date if parsing fails
  }

  // Safely parse the category, using firstWhere and providing a fallback for invalid values
  Category category;
  try {
  category = Category.values.firstWhere(
  (e) => e.toString().split('.').last == map['category'],
  orElse: () => Category.food,  // Default category if not found
);

    // category = Category.values.firstWhere(
    //   (e) => e.toString() == 'Category.' + map[SqlQueries.category].toString(),
    //   orElse: () => Category.food, // Fallback in case the category is not found
    // );
  } catch (e) {
    print('Error parsing category: $e');
    category = Category.food;  // Default category in case of error
  }

  return Expense(
    title: map[SqlQueries.title]?.toString() ?? '',
    amount: (map[SqlQueries.amount] as num?)?.toDouble() ?? 0.0,
    date: date,
    category: category,
    uid: int.tryParse(map['uid'].toString()) ?? 0,
  );
}


    Map<String,dynamic> toMap()
    {
      return {
        SqlQueries.uid : uid,
        SqlQueries.title: title,
        SqlQueries.amount: amount,
        SqlQueries.date: date.toIso8601String(),
        SqlQueries.category: category.name
      };
    }
}
