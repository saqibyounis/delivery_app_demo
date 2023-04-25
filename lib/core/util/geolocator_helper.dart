import 'package:geolocator/geolocator.dart';

class GeolocatorHelper {
  static final GeolocatorHelper _instance = GeolocatorHelper._internal();
  factory GeolocatorHelper() {
    return _instance;
  }

  GeolocatorHelper._internal() {}

  Future<double> calculateDistanceBetweenTwoPointsInMiles(
      double startLat, double startLng, double endLat, double endLng) async {
    double distanceInMeters = await Geolocator.distanceBetween(
      startLat,
      startLng,
      endLat,
      endLng,
    );

    return distanceInMeters * 0.000621371192;
  }
}
