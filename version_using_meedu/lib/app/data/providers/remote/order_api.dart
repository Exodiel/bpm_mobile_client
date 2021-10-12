import 'package:dio/dio.dart';
import 'package:google_maps/app/data/providers/local/authentication_client.dart';
import 'package:google_maps/app/domain/models/order.dart';

class OrderAPI {
  final Dio _dio;
  final AuthenticationClient _authenticationClient;

  OrderAPI(this._dio, this._authenticationClient);

  Future<Order?> saveOrder(Order order) async {
    try {
      final token = await _authenticationClient.accessToken;
      final userId = await _authenticationClient.userId;
      final body = {
        'date': order.date,
        'discount': 0.0,
        'subtotal': order.subtotal,
        'tax': order.tax,
        'total': order.total,
        'description': order.description,
        'type': order.type,
        'payment': order.payment,
        'state': order.state,
        'address': order.address,
        'origin': order.origin,
        'userId': int.parse(userId!),
        'personId': int.parse(userId),
      };
      final response = await _dio.post(
        'http://192.168.0.103:8000/api/v1/order/create',
        data: body,
        options: Options(
          headers: {'Authorization': "Bearer $token"},
        ),
      );
      final data = response.data;
      final json = Order.fromJson(data);
      return json;
    } catch (e) {
      print(e);
    }
  }

  Future<List<Orders>?> getTransactionsByLoggedUser() async {
    final token = await _authenticationClient.accessToken;
    final userId = await _authenticationClient.userId;
    try {
      final response = await _dio.get(
        'http://192.168.0.103:8000/api/v1/order/get-transactions-by-person/${userId!}',
        options: Options(
          headers: {'Authorization': "Bearer $token"},
        ),
      );
      final data = response.data;
      List<Orders> orders = [];
      data.forEach((json) {
        final order = Orders.fromJson(json);
        orders.add(order);
      });
      return orders;
    } catch (e) {
      print(e);
    }
  }
}
