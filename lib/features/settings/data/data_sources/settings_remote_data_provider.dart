import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movie_mate/core/constants/firebase_constants.dart';
import 'package:movie_mate/core/utils/user_service.dart';
import 'package:movie_mate/features/home/data/models/genre_model.dart';

abstract class SettingsRemoteDataProvider{
  Future<void> saveSelectedGenres( List<int> genres);
  Future<List<int>> loadSelectedGenres();
}

class SettingsRemoteDataProviderImpl extends SettingsRemoteDataProvider{
  final FirebaseFirestore _fireStore;
  final UserService _userService;

  SettingsRemoteDataProviderImpl(this._fireStore, this._userService);

  @override
  Future<void> saveSelectedGenres( List<int> genres) async {
    try {
      final userId = await _userService.getOrCreateUserUuid();
      await _fireStore.collection(FireStoreConst.users).doc(userId).set({
      FireStoreConst.selectedGenres: genres,
      }, SetOptions(merge: false));
    } catch (e) {
      throw Exception('Failed to save genres: $e');
    }
  }

  @override
  Future<List<int>> loadSelectedGenres() async {
    try {
      final userId = await _userService.getOrCreateUserUuid();
      // Retrieve the user's selected genres
      final DocumentSnapshot snapshot = await _fireStore.collection(FireStoreConst.users).doc(userId).get();

      if (snapshot.exists && snapshot.data() != null) {
        final data = snapshot.data() as Map<String, dynamic>;
        return List<int>.from(data[FireStoreConst.selectedGenres] ?? []);
      }
      return [];
    } catch (e) {
      throw Exception('Failed to load genres: $e');
    }
  }
}