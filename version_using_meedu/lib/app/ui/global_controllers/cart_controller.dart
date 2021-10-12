import 'dart:async';

import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:google_maps/app/domain/models/product.dart';

class CartController extends SimpleNotifier {
  final _cartStreamController = StreamController<List<Product>>.broadcast();

  Stream<List<Product>> get streamController => _cartStreamController.stream;

  final List<Product> _items = [];

  List<Product> get items => _items;

  double _subtotal = 0;
  double _tax = 0;
  double _total = 0;

  double get subtotal => _subtotal;
  double get tax => _tax;
  double get total => _total;

  void addToCart(Product item) {
    _items.add(item);
    calculate();
    _cartStreamController.sink.add(_items);
    notify();
  }

  void removeFromCart(Product item) {
    _items.removeWhere((element) => element.id == item.id);
    calculate();
    _cartStreamController.sink.add(_items);
    notify();
  }

  void recalculate(Product item) {
    _items[_items.indexWhere((element) => element.id == item.id)] = item;
    calculate();
    _cartStreamController.sink.add(_items);
    notify();
  }

  void calculate() {
    _subtotal = 0;
    _tax = 0;
    _total = 0;
    for (var element in _items) {
      _subtotal += element.subtotal;
      _tax += (element.subtotal * 0.12);
    }
    _total = _subtotal + _tax;
  }

  bool productExistsInCart(int id) {
    if (_items.isNotEmpty) {
      final foundPeople = _items.where((element) => element.id == id);
      if (foundPeople.isNotEmpty) {
        return true;
      }
      return false;
    }
    return false;
  }


  void clearCart() {
    _items.clear();
    _subtotal = 0;
    _tax = 0;
    _total = 0;
  }

  @override
  void dispose() {
    _cartStreamController.close();
    super.dispose();
  }
}

final cartProvider = SimpleProvider(
  (_) => CartController(),
  autoDispose: false,
);
