import "dart:developer" as dev;

import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRemoteDataSource {
  Future<bool> isUserLoggedIn();
  Future<User> login(String email, String password);
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
  Future<User> login(String email, String password) async {
    try {
      dev.log("Attempting to log in with email: $email", name: "Login mail");
      final userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      dev.log("Login successful");
      return userCredential.user!;
    } catch (e) {
      dev.log("Login failed with error: $e");
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
