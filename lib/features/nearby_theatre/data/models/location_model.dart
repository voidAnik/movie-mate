
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:movie_mate/features/nearby_theatre/data/models/theatre_model.dart';

class LocationModel{
  final Position position;
  final List<TheaterModel> theaters;

  LocationModel(this.position, this.theaters);
}