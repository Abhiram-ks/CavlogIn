import 'package:admin/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FetchUserRepository {
  Stream<UserModel?> streamUserData (String userUid);
}

class FetchUserRepositoryImpl implements FetchUserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Stream<UserModel?> streamUserData(String userUid) {
    return _firestore
    .collection('users')
    .doc(userUid)
    .snapshots()
    .map((snapshot) {
      if (snapshot.exists) {
        try {
          return UserModel.fromMap(snapshot.id, snapshot.data() as Map<String, dynamic>);
        } catch (e) {
          return null;
        }
      }
      return null;
    })
    .handleError((e){
      return null;
    });
  }
}