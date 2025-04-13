import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chat_app/models/user_model.dart';

class Firebasefunctions {
  static CollectionReference<UserModel> getUsersCollections() {
    return FirebaseFirestore.instance
        .collection('Users')
        .withConverter(
          fromFirestore: (snapshot, _) => UserModel.fromjson(snapshot.data()!),
          toFirestore: (userModel, _) => userModel.tojson(),
        );
  }

  static Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    UserCredential credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    UserModel user = UserModel(
      name: name,
      email: email,
      id: credential.user!.uid,
    );
    CollectionReference<UserModel> usersCollections = getUsersCollections();
    await usersCollections.doc(user.id).set(user);
    return user;
  }

  static Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    UserCredential credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    CollectionReference<UserModel> usersCollections = getUsersCollections();
    DocumentSnapshot<UserModel> docSnapshot =
        await usersCollections.doc(credential.user!.uid).get();
    return docSnapshot.data()!;
  }

  static Future<void> signOut() => FirebaseAuth.instance.signOut();
}
