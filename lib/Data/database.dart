
abstract class Database_layer
{
  Future<dynamic> connect(); //for opening the connection
  Future<void> insert(String tableName, Map<String, dynamic> data); //for inserting into a table
  Future<List<dynamic>> read(String tableName); //for reading from a table
  Future<void> delete(String tableName, int key); //for deleting from a table
  Future<void> close(); //for closing the connection
}