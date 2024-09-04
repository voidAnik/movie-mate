import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:movie_mate/core/database/database_manager.dart';
import 'package:movie_mate/core/database/favorite_movie_dao.dart';
import 'package:movie_mate/core/database/genre_dao.dart';
import 'package:movie_mate/core/database/movie_dao.dart';
import 'package:movie_mate/core/database/selected_genre_dao.dart';
import 'package:movie_mate/core/network/api_client.dart';
import 'package:movie_mate/core/utils/genre_service.dart';
import 'package:movie_mate/core/utils/network_info.dart';
import 'package:movie_mate/features/home/data/data_sources/home_local_data_provider.dart';
import 'package:movie_mate/features/home/data/data_sources/home_remote_data_provider.dart';
import 'package:movie_mate/features/home/data/repositories/home_repository_impl.dart';
import 'package:movie_mate/features/home/domain/repositories/home_repository.dart';
import 'package:movie_mate/features/home/domain/use_cases/get_trending_movies.dart';
import 'package:movie_mate/features/home/domain/use_cases/get_upcoming_movies.dart';
import 'package:movie_mate/features/home/domain/use_cases/search_movies.dart';
import 'package:movie_mate/features/home/presentation/blocs/movie_search_cubit.dart';
import 'package:movie_mate/features/home/presentation/blocs/trending_movies_cubit.dart';
import 'package:movie_mate/features/home/presentation/blocs/upcoming_movies_cubit.dart';
import 'package:movie_mate/features/movie_details/data/data_sources/movie_detail_remote_data_provider.dart';
import 'package:movie_mate/features/movie_details/data/repositories/movie_detail_repository_impl.dart';
import 'package:movie_mate/features/movie_details/domain/repositories/movie_detail_repository.dart';
import 'package:movie_mate/features/movie_details/domain/use_cases/get_movie_details.dart';
import 'package:movie_mate/features/movie_details/domain/use_cases/get_movie_images.dart';
import 'package:movie_mate/features/movie_details/presentation/blocs/movie_details_cubit.dart';
import 'package:movie_mate/features/movie_details/presentation/blocs/movie_images_cubit.dart';

final getIt = GetIt.instance;

Future<void> init() async {

  //* Core
  getIt
    ..registerLazySingleton(()=> ApiClient())
    ..registerLazySingleton(()=> InternetConnectionChecker())
    ..registerLazySingleton<NetworkInfo>(()=> NetworkInfoImpl(getIt()))
  ..registerLazySingleton(()=> GenreService());

  //? database
  getIt.registerLazySingleton(()=> DatabaseManager());
  final db = await getIt<DatabaseManager>().database;
  getIt
    ..registerLazySingleton(()=> MovieDao(db))
    ..registerLazySingleton(()=> FavoriteMovieDao(db))
    ..registerLazySingleton(()=> GenreDao(db))
    ..registerLazySingleton(()=> UserSelectedGenreDao(db));

  //* data providers
  getIt
    ..registerLazySingleton<HomeRemoteDataProvider>(()=> HomeRemoteDataProviderImpl(getIt()))
    ..registerLazySingleton<HomeLocalDataProvider>(()=> HomeLocalDataProviderImpl(getIt(), getIt()))
    ..registerLazySingleton<MovieDetailRemoteDataProvider>(()=> MovieDetailRemoteDataProviderImpl(getIt()));

  //* Repositories
  getIt
      ..registerLazySingleton<HomeRepository>(()=> HomeRepositoryImpl(getIt(), getIt(), getIt()))
      ..registerLazySingleton<MovieDetailRepository>(()=> MovieDetailRepositoryImpl(getIt()));


  //* Use Cases
  getIt
    ..registerLazySingleton(()=> GetTrendingMovies(getIt()))
    ..registerLazySingleton(()=> GetUpcomingMovies(getIt()))
    ..registerLazySingleton(()=> GetMovieImages(getIt()))
    ..registerLazySingleton(()=> GetMovieDetails(getIt()))
    ..registerLazySingleton(()=> SearchMovies(getIt()));

  //* Blocs
  getIt
    ..registerFactory(()=> TrendingMoviesCubit(getIt()))
    ..registerFactory(()=> UpcomingMoviesCubit(getIt()))
    ..registerFactory(()=> MovieImagesCubit(getIt()))
    ..registerFactory(()=> MovieDetailsCubit(getIt()))
    ..registerFactory(()=> MovieSearchCubit(getIt()));





}