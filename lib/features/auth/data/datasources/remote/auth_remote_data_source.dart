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
      print("Attempting to log in with email: $email");
      final userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: "robinsrk3@gmail.com",
        password: "nehakakkar",
      );
      print("Login successful");
      return userCredential.user!;
    } catch (e) {
      print("Login failed with error: $e");
      rethrow;
    }
  }

  @override
  Future<User> signup(String email, String password) async {
    try {
      print("Attempting to sign up with email: $email");
      final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("Signup successful");
      return userCredential.user!;
    } catch (e) {
      print("Signup failed with error: $e");
      rethrow;
    }
  }
}
