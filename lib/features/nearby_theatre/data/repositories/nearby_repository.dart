

import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:movie_mate/core/error/failures.dart';
import 'package:movie_mate/core/network/return_failure.dart';
import 'package:movie_mate/features/nearby_theatre/data/data_sources/nearby_remote_data_provider.dart';
import 'package:movie_mate/features/nearby_theatre/data/models/location_model.dart';

class NearbyRepository{
  final NearbyRemoteDataProvider remoteDataProvider;

  NearbyRepository(this.remoteDataProvider);

  Future<Either<Failure, LocationModel>> getNearbyTheatres({required Position position}) async {
    try {
      final theatres = await remoteDataProvider.fetchTheaters(position);
      return Right(LocationModel(position, theatres));
    } catch(e) {
      log('exception: $e');
      return ReturnFailure<LocationModel>()(e as Exception);
    }
  }
}