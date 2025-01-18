import 'dart:async';
import 'package:expense_tracker/models/expense.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:uuid/uuid.dart';

class SQLiteDatabaseService {
  static Database? _database; //Database object from sqflite
  final String _tableName = 'Expenses';
  final String _uid = 'uid';
  final String _title = 'title';
  final String _amount = 'amount';
  final String _date = 'date';
  final String _category = 'category';

  static final SQLiteDatabaseService instance =
      SQLiteDatabaseService._constructor();

  SQLiteDatabaseService._constructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await getdatabase();
    return _database!;
  }

  Future<Database> getdatabase() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, 'expense_tracker.db');
    final database = await openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE Expenses (
        $_uid TEXT PRIMARY KEY,
        $_title TEXT NOT NULL,
        $_amount REAL NOT NULL,
        $_date TEXT NOT NULL,
        $_category TEXT NOT NULL)
        ''');
        //for checking purpose
        await db.insert(
          'Expenses',
          {
            _uid: Uuid().v4(), // Generate a unique ID for the sample expense
            _title: 'Sample Expense',
            _amount: 100.0,
            _date: DateTime.now()
                .toIso8601String(), // Current date in ISO 8601 format
            _category: Category.food.name, // Store category as text
          },
        );
      },
    );
    return database;
  }

  void addExpense(Expense expense) async {
    final db = await database;
    final mapObject = {
      _uid: expense.uid,
      _title: expense.title,
      _amount: expense.amount,
      _date: expense.date.toIso8601String(),
      _category: expense.category.name
    };
    await db.insert('Expenses', mapObject);
  }

  Future<List<Expense>> getExpenses() async {
    final Database db = await database;
    final allExpenses = await db.query('Expenses');
    return List.generate(allExpenses.length, (i) {
      return Expense(
        title: allExpenses[i][_title].toString(),
        amount: (allExpenses[i][_amount] as num?)?.toDouble() ?? 0.0,
        date: DateTime.parse(allExpenses[i][_date].toString()),
        category: Category.values.firstWhere((e) =>
            e.toString() == 'Category.' + allExpenses[i][_category].toString()),
      );
    });
  }
}
