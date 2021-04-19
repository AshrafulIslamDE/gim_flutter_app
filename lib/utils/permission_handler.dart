import 'package:permission_handler/permission_handler.dart';

class PermissionsHandler {

  Future<bool> _requestPermission(Permission permission) async {
    var status = await permission.request();
    return status == PermissionStatus.granted;
  }

  Future<bool> requestLocPermission({Function onPermissionDenied}) async {
    var granted = await _requestPermission(Permission.locationWhenInUse);
    if (!granted) {
      onPermissionDenied();
    }
    return granted;
  }

  Future<bool> requestLocationPermission() async {
    return _requestPermission(Permission.locationWhenInUse);
  }

  Future<bool> hasLocationPermission() async {
    return hasPermission(Permission.locationWhenInUse);
  }

  Future<bool> hasPermission(Permission permission) async {
    return await permission.status == PermissionStatus.granted;
  }
}
