import "dart:developer" as dev;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthRemoteDataSource {
  Future<bool> isAdmin();
  Future<bool> isUserLoggedIn();
  Future<User> login();
  Future<User> signup(String email, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;

  AuthRemoteDataSourceImpl(this.firebaseAuth);

  @override
  Future<bool> isAdmin() async {
    print('isadmin checking');
    final user = firebaseAuth.currentUser;
    if (user == null) {
      return false;
    }

    try {
      // Reference to the user's profile in the Realtime Database
      final DatabaseReference userRef = FirebaseDatabase.instance
          .ref()
          .child('users')
          .child(user.uid)
          .child('profile');

      // Fetch the user data once
      final DatabaseEvent event = await userRef.once();
      final DataSnapshot snapshot = event.snapshot;

      if (snapshot.exists) {
        // Retrieve the 'role' field from the profile
        final String role = snapshot.child('role').value as String;
        // Check if the role is 'admin'
        print("user role is $role");
        return role == 'admin';
      } else {
        return false; // User profile does not exist in the database
      }
    } catch (e) {
      print("Error fetching admin role: $e");
      return false;
    }
  }

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
          await FirebaseAuth.instance.signInWithCredential(credential);

      final User? user = userCredential.user;

      if (user != null) {
        // Create a reference to the user node in Firebase Realtime Database
        final DatabaseReference userRef = FirebaseDatabase.instance
            .ref()
            .child('users')
            .child(user.uid)
            .child("profile");

        // Check if user data already exists
        final DatabaseEvent event = await userRef.once();
        final DataSnapshot snapshot = event.snapshot;

        if (!snapshot.exists) {
          // Get the user's profile information
          final String displayName = user.displayName ?? "N/A";
          final String email = user.email ?? "N/A";
          final String photoURL = user.photoURL ?? "N/A";

          // Set the user's information
          await userRef.set({
            'displayName': displayName,
            'email': email,
            'photoURL': photoURL,
            'role': 'user',
          });
        }

        // Return the logged-in user
        return user;
      } else {
        throw Exception("User is null");
      }
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
