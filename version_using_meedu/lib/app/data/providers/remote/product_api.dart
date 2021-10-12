import 'package:dio/dio.dart';
import 'package:google_maps/app/data/providers/local/authentication_client.dart';
import 'package:google_maps/app/domain/models/product.dart';

class ProductAPI {
  final Dio _dio;
  final AuthenticationClient _authenticationClient;

  ProductAPI(this._dio, this._authenticationClient);

  Future<List<Product>?> findProductsByCategory(int categoryId) async {
    try {
      final token = await _authenticationClient.accessToken;
      final response = await _dio.get(
        'http://192.168.0.103:8000/api/v1/product/get-products-by-category/$categoryId',
        options: Options(
          headers: {'Authorization': "Bearer $token"},
        ),
      );
      final body = response.data;
      List<Product> products = [];

      body['data'].forEach((json) {
        final product = Product.fromJson(json);
        products.add(product);
      });
      return products;
    } on DioError catch (e) {
      print(e);
    }
  }
}
