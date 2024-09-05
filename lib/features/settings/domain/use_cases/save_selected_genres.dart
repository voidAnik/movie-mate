import 'package:dartz/dartz.dart';
import 'package:movie_mate/core/error/failures.dart';
import 'package:movie_mate/core/use_cases/use_case.dart';
import 'package:movie_mate/features/settings/domain/repositories/settings_repository.dart';

class SaveSelectedGenres extends UseCase<void, List<int>>{
  final SettingsRepository repository;

  SaveSelectedGenres(this.repository);

  @override
  Future<Either<Failure, void>> call({required List<int> params}) {
    return repository.saveSelectedGenres(genreIds: params);
  }

}