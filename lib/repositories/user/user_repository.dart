import 'package:cloud_firestore/cloud_firestore.dart';

import '../../config/paths.dart';
import '../../models/models.dart';
import '../../repositories/repositories.dart';

class UserRepository extends BaseUserRepository {
  final FirebaseFirestore _firebaseFirestore;
  UserRepository({FirebaseFirestore? firebaseFirestore}) : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Future<UserModel> getUserWithId({required String userId}) async {
    final doc = await _firebaseFirestore.collection(Paths.users).doc(userId).get();
    return doc.exists ? UserModel.fromDocument(doc) : UserModel.empty;
  }

  @override
  Future<void> updateUser({required UserModel user}) async {
    await _firebaseFirestore.collection(Paths.users).doc(user.id).update(user.toDocument());
  }
}
