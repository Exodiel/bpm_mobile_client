import 'package:google_maps/app/domain/models/category.dart';

abstract class CategoryRepository {
  Future<List<Category>> find();
}