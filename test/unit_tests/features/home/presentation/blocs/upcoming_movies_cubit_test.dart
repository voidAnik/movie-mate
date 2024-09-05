import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:movie_mate/core/blocs/common_api_state.dart';
import 'package:movie_mate/core/error/failures.dart';
import 'package:movie_mate/features/home/data/models/movie_model.dart';
import 'package:movie_mate/features/home/domain/use_cases/get_upcoming_movies.dart';
import 'package:movie_mate/features/home/presentation/blocs/upcoming_movies_cubit.dart';

import 'upcoming_movies_cubit_test.mocks.dart';


@GenerateMocks([GetUpcomingMovies])
void main() {
  late UpcomingMoviesCubit cubit;
  late MockGetUpcomingMovies mockGetUpcomingMovies;

  setUp(() {
    mockGetUpcomingMovies = MockGetUpcomingMovies();
    cubit = UpcomingMoviesCubit(
      mockGetUpcomingMovies,
    );
  });

  test('initial state should be ApiInitial', () {
    // assert
    expect(cubit.state, equals(ApiInitial()));
  });

  group('GetUpcomingMovies', () {
    final MovieModel tMovieModel = MovieModel(
      id: 1,
      title: 'Test Movie',
      originalTitle: 'Test Movie Original',
      overview: 'Test Overview',
      posterPath: 'test_poster_path',
      backdropPath: 'test_backdrop_path',
      genreIds: [1, 2],
      popularity: 10.0,
      releaseDate: '2024-01-01',
      voteAverage: 8.0,
      voteCount: 100,
      adult: false,
      video: false,
      originalLanguage: 'en',
    );
    final tUpcomingMovies = List.filled(15, tMovieModel);

    blocTest<UpcomingMoviesCubit, CommonApiState>(
      'should emit [ApiSuccess] when data is successfully fetched',
      build: () {
        when(mockGetUpcomingMovies(params: anyNamed('params'))).thenAnswer((_) async => Right(tUpcomingMovies));
        return cubit;
      },
      act: (cubit) => cubit.fetchMovies(),
      expect: () => [
        ApiSuccess(response: tUpcomingMovies),
      ],
    );

    blocTest<UpcomingMoviesCubit, CommonApiState>(
      'should emit [ApiError] when data fetch fails with ServerFailure',
      build: () {
        when(mockGetUpcomingMovies(params: anyNamed('params'))).thenAnswer((_) async => const Left(ServerFailure(error: 'SERVER_FAILURE')));
        return cubit;
      },
      act: (cubit) => cubit.fetchMovies(),
      expect: () => [const ApiError(message: 'SERVER_FAILURE')],
    );

    blocTest<UpcomingMoviesCubit, CommonApiState>(
      'should emit [ApiError] with a proper message for Unknown Exception',
      build: () {
        when(mockGetUpcomingMovies(params: anyNamed('params'))).thenAnswer((_) async => Left(CacheFailure()));
        return cubit;
      },
      act: (cubit) => cubit.fetchMovies(),
      expect: () => [const ApiError(message: 'Unknown Exception')],
    );
  });
}
