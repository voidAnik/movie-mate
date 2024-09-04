import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_mate/features/favorites/domain/use_cases/delete_favorite_movie.dart';
import 'package:movie_mate/features/favorites/domain/use_cases/save_favorite_movie.dart';
import 'package:movie_mate/features/home/domain/entities/movie.dart';
import 'package:movie_mate/features/movie_details/domain/use_cases/is_favorite.dart';

class AddFavoriteCubit extends Cubit<bool>{
  final SaveFavoriteMovie _saveFavoriteMovie;
  final DeleteFavoriteMovie _deleteFavoriteMovie;
  final IsFavorite _isFavorite;

  AddFavoriteCubit(this._saveFavoriteMovie, this._deleteFavoriteMovie, this._isFavorite) : super(false);

  Future<void> getIsFavorite({required int movieId}) async {
    final response = await _isFavorite(params: movieId);
    response.fold((failure){
      log('getting is favorite failed: $failure');
    }, (isFavorite){
      log('getting is favorite success: $isFavorite');
      emit(isFavorite);
    });
  }

  Future<void> toggleFavorite({required bool isFavorite, required Movie movie}) async {

    emit(!isFavorite);  // Emit the new state immediately to update the UI
    if(isFavorite){
      final response = await _deleteFavoriteMovie(params: movie.id);
      response.fold((failure){
        log('delete failed: $failure');
      }, (data){
        log('delete success');
      });
    } else {
      final response = await _saveFavoriteMovie(params: movie);
      response.fold((failure){
        log('save failed: $failure');
      }, (data){
        log('save success');
      });
    }
  }
}

