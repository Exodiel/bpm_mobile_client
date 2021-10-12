import 'package:google_maps/app/domain/models/product.dart';

abstract class ProductRepository {
  Future<List<Product>> findProductsByCategory(int categoryId);
}