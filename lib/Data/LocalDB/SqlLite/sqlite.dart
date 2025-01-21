import 'package:expense_tracker/Data/LocalDB/SqlLite/sql_queries.dart';
import 'package:expense_tracker/Data/database.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

//implementation of the database layer containing the CRUD operations

class Sqlite implements Database_layer
{
  static Database? _database; //instance of sqlite database class 
  static final Sqlite instance =
      Sqlite._constructor(); //singleton instance for the sqlite class

  Sqlite._constructor(
  );
  
  //function for returning the object after connection with the database and checking if the object exists
  @override
  Future<void> connect() async
  {
    _database ??= await _getdatabase();
    return;
  }

  //this function is private and actually gets the connection for the database
  Future<Database> _getdatabase() async
  {
    
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, SqlQueries.databaseName);
    final database = await openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(SqlQueries.createTableQuery);
        //for checking purpose
        await db.insert(
          SqlQueries.tableName,
           SqlQueries.sampleEntry, //inserting a sample entry in the database
        );
      },
    );
    return database;
  }
  
  @override
  Future<void> close() async
  {
    //some extra logic before closing if any
    await _database!.close();
  }

  @override
  Future<void> delete(String tableName, int key) async
  {
    await connect();
    int result = await _database!.delete(tableName,where: '${SqlQueries.uid} = ?',whereArgs: [key]);
    print("Result : $result");
    print('Executing SQL query: DELETE FROM $tableName WHERE ${SqlQueries.uid} = ?, with arguments: [$key]');

  }

  @override
  Future<void> insert(String tableName, Map<String, dynamic> data) async
  {
    await connect();
    await _database!.insert(tableName, data);
  }

  @override
  Future<List<dynamic>> read(String tableName) async
  {
    await connect();
    final allExpenses = await _database!.query(SqlQueries.tableName);
    print("All expenses : $allExpenses");
    return allExpenses;
  }
}