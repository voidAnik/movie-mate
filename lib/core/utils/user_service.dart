import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class UserService {
  final FirebaseFirestore _fireStore;
  final Uuid _uuid;


  UserService(this._fireStore, this._uuid);

  Future<String> getOrCreateUserUuid() async {
    final userDocRef = _fireStore.collection('users').doc('user_uuid');

    final docSnapshot = await userDocRef.get();
    if (docSnapshot.exists) {
      return docSnapshot.data()!['uuid'] as String;
    } else {
      final newUuid = _uuid.v4();
      await userDocRef.set({'uuid': newUuid});
      return newUuid;
    }
  }
}