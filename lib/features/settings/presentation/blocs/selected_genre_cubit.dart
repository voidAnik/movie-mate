import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_mate/core/error/failures.dart';
import 'package:movie_mate/core/use_cases/use_case.dart';
import 'package:movie_mate/features/favorites/presentation/blocs/favorite_movies_cubit.dart';
import 'package:movie_mate/features/settings/domain/use_cases/get_selected_genres.dart';
import 'package:movie_mate/features/settings/domain/use_cases/save_selected_genres.dart';

class SelectedGenreCubit extends Cubit<DataState>{
  final GetSelectedGenres _getSelectedGenres;
  final SaveSelectedGenres _saveSelectedGenres;
  SelectedGenreCubit(this._getSelectedGenres, this._saveSelectedGenres):super(DataInitial());

  List<int> selectedGenres = [];

  Future<void> fetchGenres() async {
    emit(DataLoading());
    final response = await _getSelectedGenres(params: NoParams());
    response.fold((failure){
      if(failure is ApiFailure){
        emit(DataError(error: failure.error));
      } else {
        emit(DataError(error: 'Cache Failure'));
      }
    }, (data){
      selectedGenres = data;
      emit(DataSuccess<List<int>>(data: data));
    });
  }

  Future<void> saveGenres({required List<int> genreIds}) async {
    emit(DataSuccess(data: genreIds));
    final response = await _saveSelectedGenres(params: genreIds);
    response.fold((failure){
      if(failure is ApiFailure){
        log('genre save failed from firebase: ${failure.error}');
      } else {
        log('genre save failed from local sql');
      }
    }, (data){
      log('genre saved successfully');
    });
  }
}