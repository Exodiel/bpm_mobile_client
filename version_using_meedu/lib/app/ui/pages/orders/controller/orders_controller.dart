import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:google_maps/app/domain/models/order.dart';
import 'package:google_maps/app/domain/repositories/order_repository.dart';

class OrdersController extends SimpleNotifier {
  final OrderRepository _orderRepository = Get.i.find();

  Future<List<Orders>> getOrdersByLoggedUser() => _orderRepository.getOrdersByLoggedUser();
}