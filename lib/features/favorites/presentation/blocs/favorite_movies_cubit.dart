import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_mate/core/error/failures.dart';
import 'package:movie_mate/core/use_cases/use_case.dart';
import 'package:movie_mate/features/favorites/domain/use_cases/delete_favorite_movie.dart';
import 'package:movie_mate/features/favorites/domain/use_cases/get_favorite_movies.dart';
import 'package:movie_mate/features/home/data/models/movie_model.dart';

class FavoriteMoviesCubit extends Cubit<DataState>{
  FavoriteMoviesCubit(this._getFavoriteMovies, this._deleteFavoriteMovie):super(DataInitial());
  final GetFavoriteMovies _getFavoriteMovies;
  final DeleteFavoriteMovie _deleteFavoriteMovie;
  List<MovieModel> movies = [];

  Future<void> fetchMovies() async {
    emit(DataLoading());
    final response = await _getFavoriteMovies(params: NoParams());
    response.fold((failure){
      if(failure is ApiFailure){
        emit(DataError(error: failure.error));
      } else {
        emit(DataError(error: 'Cache Failure'));
      }
    }, (data){
      movies = data;
      emit(DataSuccess<List<MovieModel>>(data: data));
    });
  }

  Future<void> deleteMovie({required int movieId, required int index}) async {
    movies.removeAt(index);
    List<MovieModel> updatedList = List.from(movies);
    emit(DataSuccess(data: updatedList));
    final response = await _deleteFavoriteMovie(params: movieId);
    response.fold((failure){
      if(failure is ApiFailure){
        log('movie delete failed from firebase: ${failure.error}');
      } else {
        log('movie delete failed from local sql');
      }
    }, (data){
      log('movie deleted successfully');
    });
  }
}

abstract class DataState{}
class DataInitial extends DataState{}
class DataLoading extends DataState{}

class DataSuccess<T> extends DataState{
  T data;
  DataSuccess({required this.data});

}
class DataError extends DataState{
  final String error;
  DataError({required this.error});

}