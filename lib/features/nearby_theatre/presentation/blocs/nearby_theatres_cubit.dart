import 'package:flutter_map/flutter_map.dart';
import 'package:movie_mate/core/blocs/common_api_cubit.dart';
import 'package:movie_mate/core/utils/location_service.dart';
import 'package:movie_mate/features/nearby_theatre/data/models/location_model.dart';
import 'package:movie_mate/features/nearby_theatre/data/repositories/nearby_repository.dart';

class NearbyTheatresCubit extends CommonApiCubit<LocationModel>{
  final NearbyRepository _repository;
  final LocationService _locationService;

  NearbyTheatresCubit(this._repository, this._locationService);

  Future<void> getNearbyTheatres() async {
    final position = await _locationService.getCurrentLocation();
    performApiCall(() => _repository.getNearbyTheatres(position: position!));
  }
}