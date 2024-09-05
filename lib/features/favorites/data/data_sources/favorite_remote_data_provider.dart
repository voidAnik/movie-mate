import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movie_mate/core/constants/firebase_constants.dart';
import 'package:movie_mate/core/error/exceptions.dart';
import 'package:movie_mate/core/injection/injection_container.dart';
import 'package:movie_mate/core/utils/user_service.dart';
import 'package:movie_mate/features/home/data/models/movie_model.dart';

abstract class FavoriteRemoteDataProvider{
  Future<List<MovieModel>> getFavoriteMovies();
  Future<void> deleteFavorite({required int movieId});
  Future<void> saveFavorite({required MovieModel movie});
  Future<bool> isFavorite(int movieId);
}

class FavoriteRemoteDataProviderImpl extends FavoriteRemoteDataProvider{
  final FirebaseFirestore _fireStore;
  final UserService _userService;



  FavoriteRemoteDataProviderImpl(this._fireStore, this._userService);

  @override
  Future<void> deleteFavorite({required int movieId}) async {
    try {
      final userId = await _userService.getOrCreateUserUuid();
      await _fireStore.collection(FireStoreConst.users).doc(userId)
          .collection(FireStoreConst.favoriteMovies).doc(movieId.toString())
          .delete();
    } catch (e) {
      throw ApiException(error: 'Failed to remove favorite movie: $e');
    }
  }

  @override
  Future<void> saveFavorite({required MovieModel movie}) async {
    final userId = await _userService.getOrCreateUserUuid();
    try {
      await _fireStore.collection(FireStoreConst.users).doc(userId)
          .collection(FireStoreConst.favoriteMovies).doc(movie.id.toString())
          .set({
        FireStoreConst.movieData: movie.toJson(),
      });
    } catch (e) {
      throw ApiException(error: 'Failed to save favorite movie: $e');
    }
  }

  @override
  Future<List<MovieModel>> getFavoriteMovies() async {
    final userId = await _userService.getOrCreateUserUuid();
    try {
      final snapshot = await _fireStore.collection('users').doc(userId)
          .collection(FireStoreConst.favoriteMovies).get();

      return snapshot.docs.map((doc) {
        final movieData = doc.data()[FireStoreConst.movieData] as Map<String, dynamic>;
        return MovieModel.fromCache(movieData);
      }).toList();
    } catch (e) {
      log('firebase favorite fetch error: $e');
      throw ApiException(error: 'Failed to fetch favorite movies: $e');
    }
  }

  @override
  Future<bool> isFavorite(int movieId) async {
    final userId = await _userService.getOrCreateUserUuid();
    final docSnapshot = await _fireStore
        .collection(FireStoreConst.users)
        .doc(userId)
        .collection(FireStoreConst.favoriteMovies)
        .doc(movieId.toString())
        .get();
    return docSnapshot.exists;
  }
}