import 'package:google_maps/app/data/providers/remote/product_api.dart';
import 'package:google_maps/app/domain/models/product.dart';
import 'package:google_maps/app/domain/repositories/product_repository.dart';

class ProductRepositoryImp extends ProductRepository {
  final ProductAPI _productAPI;
  ProductRepositoryImp(this._productAPI);
  @override
  Future<List<Product>> findProductsByCategory(int categoryId) async {
    final products = await _productAPI.findProductsByCategory(categoryId);
    return products!;
  }

}