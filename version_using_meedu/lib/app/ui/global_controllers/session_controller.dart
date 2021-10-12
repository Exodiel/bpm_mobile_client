import 'package:flutter_meedu/meedu.dart';
import 'package:google_maps/app/domain/models/place.dart';
import 'package:google_maps/app/domain/repositories/authentication_repository.dart';

class SessionController extends SimpleNotifier {
  final AuthenticationRepository _auth = Get.i.find();

  Future<String?> get token => _auth.accessToken;
  Future<String?> get userId => _auth.userId;

  Place? _origin, _destination;

  Place? get origin => _origin;
  Place? get destination => _destination;

  void addRoutes(Place origin, Place destination) {
    _origin = origin;
    _destination = destination;
  }

  Future<void> signOut() async {
    await _auth.logOut();
  }
}

final sessionProvider = SimpleProvider(
  (_) => SessionController(),
  autoDispose: false,
);
