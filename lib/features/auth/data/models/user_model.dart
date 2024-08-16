// import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
//
// import '../../domain/entities/user.dart';
//
// class UserModel extends User {
//   UserModel({
//     required String id, // This is the user's unique ID
//
//     required String email,
//   }) : super(id: id, email: email);
//
//   factory Usesuper.fromFirebaseUser(firebase_auth.User user) {
//     return UserMode
//       id: user.uid, // Map Firebase `uid` to your `id` field
//       email: user.email ?? '', // Handle the case where email might be null
//     );
//   }
// }
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import '../../domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.id, // This is the user's unique ID
    required super.email,
  });

  factory UserModel.fromFirebaseUser(firebase_auth.User user) {
    return UserModel(
      id: user.uid, // Map Firebase `uid` to your `id` field
      email: user.email ?? '', // Handle the case where email might be null
    );
  }
}
