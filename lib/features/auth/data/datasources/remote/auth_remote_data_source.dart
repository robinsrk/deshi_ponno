import "dart:developer" as dev;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthRemoteDataSource {
  Future<bool> isUserLoggedIn();
  Future<User> login();
  Future<User> signup(String email, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;

  AuthRemoteDataSourceImpl(this.firebaseAuth);

  @override
  Future<bool> isUserLoggedIn() async {
    final user = firebaseAuth.currentUser;
    return user != null;
  }

  @override
  Future<User> login() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser =
          await GoogleSignIn(scopes: ['email', 'profile']).signIn();

      if (googleUser == null) {
        // If the user cancels the sign-in
        throw Exception("User cancelled login");
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google user credential
      final UserCredential userCredential =
          await firebaseAuth.signInWithCredential(credential);

      // Return the logged-in user
      return userCredential.user!;
    } catch (e) {
      print("Error signing in with Google: $e");
      rethrow;
    }
  }

  @override
  Future<User> signup(String email, String password) async {
    try {
      dev.log("Attempting to sign up with email: $email");
      final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      dev.log("Signup successful");
      return userCredential.user!;
    } catch (e) {
      dev.log("Signup failed with error: $e");
      rethrow;
    }
  }
}
