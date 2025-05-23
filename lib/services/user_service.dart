import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';

class UserService {
  final _users = FirebaseFirestore.instance.collection('users');

  Future<void> createUser(User user) async {
    await _users.doc(user.id).set(user.toJson());
  }

  Future<User?> getUser(String id) async {
    final doc = await _users.doc(id).get();
    if (!doc.exists) return null;
    return User.fromJson(doc.data()!);
  }

  /// Stream of one user (by id) — live updates
  Stream<User> watchOne(String id) {
    return _users.doc(id).snapshots().where((doc) => doc.exists).map(
          (doc) => User.fromJson(doc.data()!),
    );
  }

  Future<void> updateUser(User user) {
    return _users
        .doc(user.id)
        .set(user.toJson(), SetOptions(merge: true));
  }
}
