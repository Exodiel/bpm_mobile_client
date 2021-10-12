import 'package:flutter_meedu/meedu.dart';
import 'package:google_maps/app/ui/global_controllers/session_controller.dart';
import 'package:google_maps/app/ui/routes/routes.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashController extends SimpleNotifier {
  final SessionController _sessionController;
  final Permission _locationPermission;
  String? _routeName;
  String? get routeName => _routeName;

  SplashController(this._locationPermission, this._sessionController) {
    _init();
  }

  Future<void> checkPermission() async {
    final token = await _sessionController.token;
    if (token != null) {
      final isGranted = await _locationPermission.isGranted;
      _routeName = isGranted ? Routes.START : Routes.PERMISSIONS;
    } else {
      _routeName = Routes.LOGIN;
    }
    notify();
  }

  void _init() async {
    final token = await _sessionController.token;
    if (token != null) {
      _routeName = Routes.START;
    } else {
      _routeName = Routes.LOGIN;
    }
    notify();
  }
}
