import 'package:google_maps/app/data/providers/remote/category_api.dart';
import 'package:google_maps/app/domain/models/category.dart';
import 'package:google_maps/app/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryAPI _categoryAPI;
  CategoryRepositoryImpl(this._categoryAPI);
  @override
  Future<List<Category>> find() async {
    final categories = await _categoryAPI.find();
    return categories!;
  }
}