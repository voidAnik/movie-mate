import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationService {
  Future<Position?> getCurrentLocation() async {
    final status = await Permission.location.status;
    if (!status.isGranted) {
      await Permission.location.request();
    }

    if (await Permission.location.isGranted) {
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } else {
      return null;
    }
  }
}
