import 'package:dartz/dartz.dart';
import 'package:movie_mate/core/error/failures.dart';

abstract class SettingsRepository{
  Future<Either<Failure,List<int>>> getSelectedGenres();
  Future<Either<Failure,void>> saveSelectedGenres({required List<int> genreIds});
}