import 'package:google_maps/app/data/providers/remote/order_api.dart';
import 'package:google_maps/app/domain/models/order.dart';
import 'package:google_maps/app/domain/repositories/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderAPI _orderAPI;
  OrderRepositoryImpl(this._orderAPI);
  @override
  Future<Order> save(Order order) async {
    final response = await _orderAPI.saveOrder(order);
    return response!;
  }

  @override
  Future<List<Orders>> getOrdersByLoggedUser() async {
    final response = await _orderAPI.getTransactionsByLoggedUser();
    return response!;
  }

}