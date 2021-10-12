abstract class DetailRepository {
  Future<String?> saveDetails(List<Map<String, dynamic>> json);
}