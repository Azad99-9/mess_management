import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mess_management/model/user_model.dart';
import 'package:mess_management/services/db_service.dart';

class UserService {
  static User? currentUser = FirebaseAuth.instance.currentUser;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool get loggedIn => _auth.currentUser != null;
  User? get getUser => _auth.currentUser;

  UserService() {
    _auth.authStateChanges().listen((onData) {
      print(onData);
    });
  }


  Future<User?> googleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication authDetails = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: authDetails.accessToken,
        idToken: authDetails.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(credential);

      return userCredential.user;
    } catch (e) {
      print('Error during Google Sign-In: $e');
      return null;
    }
  }

  Future<void> logOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  Future<void> createNewUser(UserModel user) async {
    await DBService.users.doc(user.uid).set(user.toJson());
    return;
  }

}