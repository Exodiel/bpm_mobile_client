import 'package:dio/dio.dart';
import 'package:google_maps/app/data/providers/local/authentication_client.dart';

class DetailAPI {
  final Dio _dio;
  final AuthenticationClient _authenticationClient;

  DetailAPI(this._dio, this._authenticationClient);

  Future<String?> saveDetails(List<Map<String, dynamic>> json) async {
    try {
      final token = await _authenticationClient.accessToken;
      final response = await _dio.post(
        'http://192.168.0.103:8000/api/v1/detail/create',
        data: {
          'data': json,
        },
        options: Options(
          headers: {
            'Authorization': "Bearer $token"
          }
        )
      );
      final data = response.data;

      return data['message'];
    } on DioError catch(e) {
      print(e);
    }
  }
}