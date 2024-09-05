import 'package:dartz/dartz.dart';
import 'package:movie_mate/core/error/exceptions.dart';
import 'package:movie_mate/core/error/failures.dart';
import 'package:movie_mate/core/network/return_failure.dart';
import 'package:movie_mate/core/utils/network_info.dart';
import 'package:movie_mate/features/settings/data/data_sources/settings_local_data_provider.dart';
import 'package:movie_mate/features/settings/data/data_sources/settings_remote_data_provider.dart';
import 'package:movie_mate/features/settings/domain/repositories/settings_repository.dart';

class SettingsRepositoryImpl extends SettingsRepository{
  final SettingsRemoteDataProvider remoteDataProvider;
  final SettingsLocalDataProvider localDataProvider;
  final NetworkInfo networkInfo;

  SettingsRepositoryImpl(this.remoteDataProvider, this.localDataProvider, this.networkInfo);

  @override
  Future<Either<Failure, List<int>>> getSelectedGenres() async {
    if (await networkInfo.isConnected) {
      try {
        final genreIds = await remoteDataProvider.loadSelectedGenres();
        return Right(genreIds);
      } catch (e) {
        return ReturnFailure<List<int>>()(e as Exception);
      }
    } else {
      try {
        final genreIds = await localDataProvider.getSelectedGenres();
        return Right(genreIds);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, void>> saveSelectedGenres({required List<int> genreIds}) async {
    String remoteFailedMessage = '';
    try {
       await remoteDataProvider.saveSelectedGenres(genreIds);
    } on ApiException catch (e) {
      remoteFailedMessage = e.error;
    }
    try {
      await localDataProvider.saveSelectedGenres(genreIds: genreIds);
      if (remoteFailedMessage.isNotEmpty) {
        return Left(ApiFailure(error: remoteFailedMessage));
      }
      return const Right(null);
    } on CacheException {
      return Left(CacheFailure());
    }
  }


}