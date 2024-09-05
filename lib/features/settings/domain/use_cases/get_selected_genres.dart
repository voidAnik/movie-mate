import 'package:dartz/dartz.dart';
import 'package:movie_mate/core/error/failures.dart';
import 'package:movie_mate/core/use_cases/use_case.dart';
import 'package:movie_mate/features/settings/domain/repositories/settings_repository.dart';

class GetSelectedGenres extends UseCase<List<int>, NoParams>{
  final SettingsRepository repository;

  GetSelectedGenres(this.repository);

  @override
  Future<Either<Failure, List<int>>> call({required NoParams params}) {
    return repository.getSelectedGenres();
  }

}