import 'package:expense_tracker/models/enums/category_enum.dart';

class SqlQueries {
  static const String tableName = 'Expenses';
  static const String uid = 'uid';
  static const String title = 'title';
  static const String amount = 'amount';
  static const String date = 'date';
  static const  String category = 'category';
  static const String databaseName = 'expense_tracker.db';

  static const String createTableQuery = '''
        CREATE TABLE $tableName (
        $uid TEXT PRIMARY KEY,
        $title TEXT NOT NULL,
        $amount REAL NOT NULL,
        $date TEXT NOT NULL,
        $category TEXT NOT NULL)
        ''';
        static final sampleEntry = {
            uid: 0, // Generate a unique ID for the sample expense
            title: 'Sample Expense',
            amount: 100.0,
            date: DateTime.now()
                .toIso8601String(), // Current date in ISO 8601 format
            category: Category.food.name, // Store category as text
        };
}