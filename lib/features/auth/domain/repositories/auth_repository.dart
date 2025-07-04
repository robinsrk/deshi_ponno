import 'package:dartz/dartz.dart';
import 'package:deshi_ponno/core/errors/failures.dart';

import '../entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, bool>> isAdmin();
  Future<Either<Failure, bool>> isUserLoggedIn();
  Future<Either<Failure, User>> login();
  Future<Either<Failure, User>> signup(String email, String password);
}
