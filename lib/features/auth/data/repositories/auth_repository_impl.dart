import "dart:developer" as dev;

import 'package:dartz/dartz.dart';
import 'package:deshi_ponno/core/errors/failures.dart';
import 'package:deshi_ponno/features/auth/data/datasources/remote/auth_remote_data_source.dart';
import 'package:deshi_ponno/features/auth/data/models/user_model.dart';
import 'package:deshi_ponno/features/auth/domain/entities/user.dart';
import 'package:deshi_ponno/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, bool>> isAdmin() async {
    try {
      final isAdmin = await remoteDataSource.isAdmin();
      return Right(isAdmin);
    } catch (e) {
      return Left(ServerFailure("Failed to check admin status: $e"));
    }
  }

  @override
  Future<Either<Failure, bool>> isUserLoggedIn() async {
    try {
      final isLoggedIn = await remoteDataSource.isUserLoggedIn();
      return Right(isLoggedIn);
    } catch (e) {
      // Handle specific exceptions and return corresponding Failure
      return Left(ServerFailure("Server failure"));
    }
  }

  @override
  Future<Either<Failure, User>> login() async {
    try {
      final firebaseUser = await remoteDataSource.login();
      dev.log("$firebaseUser");
      final user = UserModel.fromFirebaseUser(firebaseUser);
      return Right(user);
    } catch (e) {
      return Left(ServerFailure("Server error occurred: $e"));
    }
  }

  @override
  Future<Either<Failure, User>> signup(String email, String password) async {
    try {
      final firebaseUser = await remoteDataSource.signup(email, password);
      final user = UserModel.fromFirebaseUser(firebaseUser);
      return Right(user);
    } catch (e) {
      return Left(ServerFailure("Server error occurred: $e"));
    }
  }
}
