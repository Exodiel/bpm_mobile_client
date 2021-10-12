import 'package:dio/dio.dart';
import 'package:google_maps/app/data/providers/local/authentication_client.dart';
import 'package:google_maps/app/domain/models/category.dart';

class CategoryAPI {
  final Dio _dio;
  final AuthenticationClient _authenticationClient;
  
  CategoryAPI(this._dio, this._authenticationClient);

  Future<List<Category>?> find() async {
    try {
      final token = await _authenticationClient.accessToken;
      final response = await _dio.get(
        'http://192.168.0.103:8000/api/v1/category/find',
        options: Options(
          headers: {
            'Authorization': "Bearer $token"
          }
        )
      );
      final data = response.data;
      List<Category> categories = [];
      data.forEach((json) {
        final category = Category.fromJson(json);
        categories.add(category);
      });
      return categories;
    } on DioError catch(e) {
      print(e);
    }
  }
}