import 'package:google_maps/app/domain/models/order.dart';

abstract class OrderRepository {
  Future<Order> save(Order order);

  Future<List<Orders>> getOrdersByLoggedUser();
}