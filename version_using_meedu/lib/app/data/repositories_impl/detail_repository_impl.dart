import 'package:google_maps/app/data/providers/remote/detail_api.dart';
import 'package:google_maps/app/domain/repositories/detail_repository.dart';

class DetailRepositoryImpl extends DetailRepository {
  final DetailAPI _detailAPI;
  DetailRepositoryImpl(this._detailAPI);

  @override
  Future<String?> saveDetails(List<Map<String, dynamic>> json) {
    return _detailAPI.saveDetails(json);
  }
}
