import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../authentication/register/models/user_model.dart';
import '../home/models/verified-user-model.dart';

class SubspaceStore {
  static final SubspaceStore _apiService = SubspaceStore._internal();

  factory SubspaceStore() {
    return _apiService;
  }

  SubspaceStore._internal();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth authUser = FirebaseAuth.instance;

  Future<dynamic> createUser(
      {required UserCredential credential, required UserModel model}) async {
    try {
      await _firestore
          .collection("users")
          .doc(credential.user!.uid)
          .set(model.toJson());
    } catch (e) {
      print(e);
    }
  }

  Future<VerifiedUser?> getUserDetails() async {
    try {
      var x = await _firestore
          .collection("users")
          .doc(authUser.currentUser!.uid)
          .get();
      return VerifiedUser.fromJson(x.data()!);
    } catch (e) {
      return null;
    }
  }
}
