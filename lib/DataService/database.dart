abstract class Database_Service {
  Future<void> connect();
  Future<int> insert(String tableName, Map<String, dynamic> data);
  Future<List<Map<String, dynamic>>> query(String sql);
  Future<void> close();
}